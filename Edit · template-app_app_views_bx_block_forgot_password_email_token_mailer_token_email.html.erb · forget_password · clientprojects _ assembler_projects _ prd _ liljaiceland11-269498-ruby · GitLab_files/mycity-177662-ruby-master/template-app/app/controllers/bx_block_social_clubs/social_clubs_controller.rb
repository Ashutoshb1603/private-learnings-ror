module BxBlockSocialClubs
	class SocialClubsController < BxBlockSocialClubs::ApplicationController
		before_action :validate_json_web_token, except: [:index, :approved_social_clubs, :show, :place_lists, :club_events]
		before_action :current_user, only: [:create, :update, :destroy, :my_social_clubs, :existing_joined_clubs, :client_conversation, :create_group_chat, :serialization_options]
		before_action :find_social_club, only: %i[update destroy]
		before_action :page_from_params
		before_action :validate_bolcked_user, only: [:create, :update, :destroy]
		before_action :create_client, only: [:create_participants, :create_group_chat, :create, :message_push_notification]
		before_action :resize_image, only: [:create,:update]
		
	  def create
			@social_club = @current_user.social_clubs.new(social_club_params)
			if @social_club.save
				BxBlockSocialClubs::CreateChatJob.perform_later(@social_club, @current_user)
			  render json: BxBlockSocialClubs::SocialClubSerializer.new(@social_club,
					meta: { message: 'Social Club Created successfully..!' })
							.serializable_hash, status: :created
			else
			  render json: { errors: @social_club.errors }, status: :unprocessable_entity
			end	  	
	  end

	  def show
	  	social_club = BxBlockSocialClubs::SocialClub.find_by_id(params[:id])
	  	if request.headers[:token].present?
	  		validate_json_web_token
	  		current_user
	  	end

	  	if social_club.present?		
				render json: BxBlockSocialClubs::SocialClubSerializer.new(social_club, serialization_options).
						serializable_hash, status: :ok
			else
				render json: {status: 422, message: 'Invalid social club id'}, status: 422
			end
	  end

	  def update
			if @social_club.update(social_club_params)
				render json: BxBlockSocialClubs::SocialClubSerializer.new(@social_club,
					meta: { message: 'Social Club Updated successfully..!' }).serializable_hash,
		    	status: :ok
			else
				render json: { errors: @social_club.errors.full_messages }, 
				status: :unprocessable_entity	
			end		
	  end

	  def destroy
			@social_club.destroy
			render json: { message: "Social Club deleted successfully" }, status: :ok
	  end

	  def my_social_clubs
	  	social_clubs = @current_user.social_clubs.order(created_at: :desc)
	  	if params[:search].present?
	  		social_clubs = social_clubs.search_by_words(params[:search])
	  	end
	  	social_clubs = social_clubs.page(@page).per(@per_page)
	  	render json: BxBlockSocialClubs::MyClubSerializer.new(social_clubs, serialization_options).serializable_hash,
		    	status: :ok
	  end

	  def club_events
	  	if request.headers[:token].present?
	  		validate_json_web_token
	  		current_user
	  	end

	  	if params[:social_club_id].present?
	  		social_club = BxBlockSocialClubs::SocialClub.find_by_id(params[:social_club_id])
	  		if social_club.blank?
	  			return render json: {status: 422, error: 'Invalid social club id'}, status: 422
	  		else
	  			events = social_club.club_events.order(end_date_and_time: :desc).page(@page).per(@per_page)
	  			data = BxBlockClubEvents::ClubEventSerializer.new(events, serialization_options).serializable_hash
	  			render json: {status: 200, data: data }, status: 200
	  		end
	  	else
	  		render json: {status: 422, error: 'social club id is missing'}, status: 422
	  	end
	  end

	  def existing_joined_clubs
	  	account_social_clubs = BxBlockSocialClubs::AccountSocialClub.where(account_id: @current_user.id).order(created_at: :desc).page(@page).per(@per_page)
	  	social_clubs = []

	  	if account_social_clubs.exists?
	  		social_clubs = BxBlockSocialClubs::SocialClub.where(id: account_social_clubs.pluck(:social_club_id))
			end

	  	render json: BxBlockSocialClubs::MyClubSerializer.new(social_clubs, serialization_options).serializable_hash,
		    	status: :ok
	  end

	  def place_lists
	  	if params[:social_club_id].present?
	  		social_club = BxBlockSocialClubs::SocialClub.find_by_id(params[:social_club_id])
	  		if social_club.blank?
	  			return render json: {status: 422, error: 'Invalid social club id'}, status: 422
	  		else
	  			events = social_club.club_events
	  			if params[:search].present?
	  				events = events.where('location ILIKE :search or event_name ILIKE :search', search: "%#{params[:search]}%")
	  			end
	  			events = events.order(created_at: :desc).page(@page).per(@per_page)
	  			data = BxBlockSocialClubs::MyClubEventsSerializer.new(events, serialization_options).serializable_hash
	  			render json: {status: 200, data: data}, status: 200
	  		end
	  	else
	  		render json: {status: 422, error: 'social club id is missing'}, status: 422
	  	end
	  end

	  private

	  def social_club_params
			params.require(:data)[:attributes].permit(:name, :description, :community_rules, :location, :language,
													:is_visible, :user_capacity, :fee_currency, :latitude, :longitude,
													:fee_amount_cents, :bank_name, :bank_account_name,
													:bank_account_number, :routing_code,
													:max_channel_count, chat_channels: [], interest_ids: [], images: [])
	  end

	  def find_social_club
			@social_club = @current_user.social_clubs.find_by_id(params[:id])
			return render json: {status: 422, message: 'Invalid social club id'}, status: 422 if @social_club.blank?
	  end

	  def serialization_options
      options = {}
      options[:params] = { current_user: @current_user }
      options
    end

		def send_notification_to_user(accounts_with_interest, social_club)
			BxBlockEmailnotifications::AdminNotificationMailer.interest_based_club_created(social_club.name, accounts_with_interest).deliver_later
			accounts = AccountBlock::Account.where(email: accounts_with_interest)
			image = social_club.images&.first&.service_url rescue nil
			accounts.each do |account_object|
        BxBlockPushNotifications::PushNotification.create(
          push_notificable: account_object,
          remarks: "Social Club Created",
					content: "New social club: #{social_club.name} of your interest has been created.",
					image: image,
					notify_type: 'social_club'
        )
      end
		end

		def validate_bolcked_user
			if @current_user.is_blacklisted?
				return render json: {status: 401, error: 'You are not allowed to perform. Your account was blocked by admin'}, status: 401
			end
		end

		def resize_image
			social_club_params[:images]&.each do |img|
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