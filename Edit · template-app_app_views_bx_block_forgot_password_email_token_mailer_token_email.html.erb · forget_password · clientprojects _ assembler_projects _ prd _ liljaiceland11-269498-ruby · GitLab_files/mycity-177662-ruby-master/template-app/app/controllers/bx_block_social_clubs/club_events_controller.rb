module BxBlockSocialClubs
  class ClubEventsController < BxBlockSocialClubs::ApplicationController
    before_action :validate_json_web_token, except: [:index, :approved_events, :show, :upcoming_events, :search_event_by_location]
    before_action :current_user, only: [:create, :update, :destroy, :my_events]
    before_action :find_club_event, only: %i[show]
    before_action :validate_club_admin, only: [:update, :destroy]
    before_action :page_from_params
    before_action :validate_bolcked_user, only: [:update, :destroy, :create]
    before_action :resize_image, only: [:create,:update]

    def index
      if params[:filter].present?
        is_visible = params[:filter][:is_visible]
        free_registration = params[:filter][:free_registration]
        @club_events = BxBlockClubEvents::ClubEvent.where("club_events.is_visible IN (?) OR club_events.is_visible IN (?)", is_visible, free_registration)
      else
        @club_events = BxBlockClubEvents::ClubEvent.all
      end
      render_club_events_result(@club_events)
    end

    def my_events
      if params[:social_club_events].present? && params[:social_club_events] == "true"
        @club_events = BxBlockSocialClubs::SocialClub.find_by_id(params[:social_club_id])&.club_events.order(end_date_and_time: :desc)
      else
        @club_events = @current_user.social_clubs.find(params[:social_club_id]).club_events.order(end_date_and_time: :desc)
      end
      render_club_events_result(@club_events)
    end

    def search_event_by_location
      @events = BxBlockClubEvents::ClubEvent.where('DATE(start_date_and_time) > ?', Date.today)
      @event = BxBlockClubEvents::ClubEvent.find_by(id: params[:event_id])
      if @event && @event.to_coordinates
        range = params[:range].present? ? params[:range].to_i : 100
        @nearest_events = @events.near(@event.to_coordinates, range, units: :km)
      end
      render json: {
        message: 'No events around this place'
        } and return unless @nearest_events.present?
      render json: BxBlockClubEvents::ClubEventSerializer.new(@nearest_events.limit(5).map{|obj| obj}) #hardcoded limit set for minimizing load time of API in Frontend
              .serializable_hash
    end

    def upcoming_events
      if request.headers[:token].present?
        validate_json_web_token
        current_user
      end

      social_club_ids = @current_user.joined_social_clubs.pluck(:id) rescue nil

      if social_club_ids.present?
        upcoming_events = BxBlockClubEvents::ClubEvent.where(social_club_id: social_club_ids).where('DATE(start_date_and_time) > ?', Date.today)
        
        if params[:search].present?
          upcoming_events = upcoming_events.search_by_words(params[:search])
        end        
      else
        lists = BxBlockAnalytics9::SearchDocument.where(status: "approved", searchable_type: 'BxBlockSocialClubs::SocialClub')
        lists = search_clubs_by_interest(lists)

        if params[:search].present?
          lists = lists.search_by_words(params[:search])
        end

        # social_clubs = lists.page(@page).per(@per_page)
        upcoming_events = BxBlockClubEvents::ClubEvent.where(social_club_id: lists.pluck(:searchable_id)).where('DATE(start_date_and_time) > ?', Date.today)

        if !upcoming_events.exists?
          language = @current_user.present? ? @current_user.language : params[:language]
          upcoming_events = BxBlockClubEvents::ClubEvent.where('DATE(start_date_and_time) > ?', Date.today)
          if language.present?
            upcoming_events = upcoming_events.joins(:social_club).where(social_clubs: {language: language.downcase})
          end
        end
      end

      upcoming_events = upcoming_events.page(@page).per(@per_page)
      # @upcoming_events = BxBlockClubEvents::ClubEvent.joins(social_club: :account).where(accounts: {id: @current_user.id})
      render json: {
        message: 'No upcoming events'
        } and return unless upcoming_events.present?

      render json: BxBlockClubEvents::ClubEventSerializer.new(upcoming_events, serialization_options).serializable_hash
    end

    def search_events_by_params
      if params[:activity_id].present?
        @club_events = BxBlockClubEvents::ClubEvent.left_outer_joins(:activities).where(activities: {id: params[:activity_id]}).distinct
      elsif params[:travel_item_id].present?
        @club_events = BxBlockClubEvents::ClubEvent.left_outer_joins(:travel_items).where(travel_items: {id: params[:travel_item_id]}).distinct
      end
      render_club_events_result(@club_events)
    end

    def approved_events
      @club_events = BxBlockClubEvents::ClubEvent.approved
      render json: {
        message: 'Approved events are not present'
        } and return unless @club_events.present?
      render json: BxBlockClubEvents::ClubEventSerializer.new(@club_events)
              .serializable_hash
    end

    def create
      @social_club = @current_user.social_clubs.find_by_id(params[:social_club_id])
      render json: {status: 404, error: 'Invalid social club'} and return if @social_club.blank?

      @club_event = @social_club.club_events.new(club_event_params)
      if @club_event.save
        render json: BxBlockClubEvents::ClubEventSerializer.new(@club_event,
        meta: { message: 'Event Created successfully..!' })
              .serializable_hash, status: :created
      else
        render json: { errors: @club_event.errors }, status: :unprocessable_entity
      end	  	
    end

    def show
      if request.headers[:token].present?
        validate_json_web_token
        current_user
      end

      render json: BxBlockClubEvents::ClubEventSerializer.new(@club_event, serialization_options).
              serializable_hash, status: :ok	
    end

    def update
      if @club_event.update(club_event_params)
        render json: BxBlockClubEvents::ClubEventSerializer.new(@club_event,
        meta: { message: 'Event Updated successfully.' }).serializable_hash,
          status: :ok
      else
        render json: { errors: @club_event.errors.full_messages }, 
        status: :unprocessable_entity	
      end		
    end

    def destroy
      @club_event.destroy
      render json: { message: "Event deleted successfully." }, status: :ok
    end

    private

    def render_club_events_result(club_events)
      club_events = club_events.page(@page).per(@per_page) if club_events
      render json: {
        message: 'Events are not present'
        } and return unless club_events.present?
      render json: BxBlockClubEvents::ClubEventSerializer.new(club_events, serialization_options)
              .serializable_hash
    end

    def club_event_params
      params.require(:data)[:attributes].permit(:event_name, :location, :longitude, :latitude, 
                                                :is_visible, :fee_currency,
                                                :start_date_and_time, :end_date_and_time, :start_time,
                                                :end_time, :max_participants, :min_participants,
                                                :description, :age_should_be, :fee_amount_cents,
                                                activity_ids: [], travel_item_ids: [], images: [])
    end

    def find_club_event
      @club_event = BxBlockClubEvents::ClubEvent.find(params[:id])
    end

    def validate_club_admin
      @social_club = @current_user.social_clubs.find_by(id: params[:social_club_id])
      return render json: {error: 'Invalid social club'}, status: 404 if @social_club.blank?

      @club_event = @social_club.club_events.find_by(id: params[:id])
      return render json: {error: 'Invalid club event'}, status: 404 if @club_event.blank?
    end

    def validate_bolcked_user
      if @current_user.is_blacklisted?
        return render json: {status: 401, error: 'You are not allowed to perform. Your account was blocked by admin'}, status: 401
      end
    end

    def search_clubs_by_interest(lists)
      if @current_user.present?
        lists = lists.where(language: @current_user.preferred_language)
        interests = @current_user.interests.pluck(:name)
      else
        lists = lists.where(language: params[:language]) if params[:language].present?
        interests = params[:interests] || []
      end

      query = ""
      if interests.present?
        interests.each_with_index do |interest, index|
          query += ' OR ' if index > 0
          query += "content ILIKE '%#{interest.downcase}%'"
        end
      end

      lists = lists.where(query) if query.present?
      lists
    end

    def serialization_options
      options = {}
      options[:params] = { current_user: @current_user }
      options
    end

    def resize_image
			club_event_params[:images]&.each do |img|
				content_type = img.content_type 
				path = img.tempfile.path
				image = MiniMagick::Image.open(path.to_s)
				image.resize "280x150"    
				if ["image/jpg","image/png","image/jpeg"].include?(content_type)
					img.tempfile = image.tempfile
				end
			end
    end
  end
end
