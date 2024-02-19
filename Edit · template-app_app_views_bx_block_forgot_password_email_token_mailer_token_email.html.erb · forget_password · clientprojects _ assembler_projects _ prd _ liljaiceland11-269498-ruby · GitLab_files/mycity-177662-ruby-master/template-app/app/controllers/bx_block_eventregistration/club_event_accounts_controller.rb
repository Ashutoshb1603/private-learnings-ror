module BxBlockEventregistration
  class ClubEventAccountsController < BxBlockEventregistration::ApplicationController
    before_action :check_club_member?, only: [:create]
    before_action :page_from_params

    def index
      @club_event_accounts = BxBlockEventregistration::ClubEventAccount.where(club_event_id: params[:event_id])&.distinct
      if @club_event_accounts.present?
        render json: BxBlockEventregistration::ClubEventAccountSerializer.new(@club_event_accounts)
          .serializable_hash, status: :ok
      else
        render json: {errors: "No participants yet" },
            status: :unprocessable_entity
      end 
    end
    
    def create
      # @event = BxBlockClubEvents::ClubEvent.find_by(id: params[:event_id])
      @club_event_account = current_user.club_event_accounts.new(club_event_id: @event&.id)
      if @club_event_account.save
        send_notification_to_user(@event, @club_event_account)
        send_email_for(@club_event_account.unique_code, current_user) if @club_event_account.unique_code
        render json: BxBlockEventregistration::ClubEventAccountSerializer.new(@club_event_account,
          meta: {message: "You have been registered successfully, an unique code has been sent to your email to identify yourself at event."})
          .serializable_hash, status: :created
      else
        render json: {errors: @club_event_account.errors.full_messages },
            status: :unprocessable_entity
      end 
    end

    def my_tickets
      club_event_accounts = current_user.club_event_accounts
      if params[:type].present? && params[:type] == 'past'
        club_event_accounts = club_event_accounts.joins(:club_event).where('DATE(club_events.end_date_and_time) < ?', Date.today)
      else
        club_event_accounts = club_event_accounts.joins(:club_event).where('DATE(club_events.end_date_and_time) > ?', Date.today)
      end

      if params[:search].present?
        club_events = BxBlockClubEvents::ClubEvent.where(id: club_event_accounts.pluck(:club_event_id)).search_by_words(params[:search])
        club_events = club_events.order(start_date_and_time: :asc).page(@page).per(@per_page)
      else
        club_event_accounts = club_event_accounts.page(@page).per(@per_page)
        club_events = BxBlockClubEvents::ClubEvent.where(id: club_event_accounts.pluck(:club_event_id))
      end

      render json: {data: BxBlockSocialClubs::MyClubEventsSerializer.new(club_events, serialization_options).serializable_hash, status: 200 }, status: 200
    end

    def ticket_details
      club_event_account = current_user.club_event_accounts.find_by(club_event_id: params[:club_event_id])
      render json: {status: 404, error: 'No record found'}, status: 404 and return if club_event_account.blank?
      render json: {status: 200, data: BxBlockClubEvents::TicketEventSerializer.new(club_event_account).serializable_hash}
    end

    private

    def check_club_member?
      @event = BxBlockClubEvents::ClubEvent.find_by(id: params[:event_id])
      return render json: {status: 404, error: 'Event not found'}, status: 422 if @event.blank?
      return render json: {status: 404, error: 'Please join the club first'}, status: 422 unless @event.social_club.account_social_clubs.where(account_id: current_user.id).exists?
      return render json: {status: 404, error: 'You already part of this event'}, status: 422 if current_user.club_event_accounts.where(club_event_id: @event&.id).exists?
      if @event.end_date_and_time < Time.now
        return render json: {status: 404, error: 'This event already expired'}, status: 404
      end
    end

    def send_email_for(unique_code, current_user)      
      UniqueCodeMailer
        .with(account: current_user, otp: unique_code, host: request.base_url)
        .email_unique_code.deliver_later
    end

    def send_notification_to_user(event, club_event_account)
      BxBlockEmailnotifications::AdminNotificationMailer.club_event_registration(event.event_name, event.social_club&.account&.email, club_event_account).deliver_later
    end

    def serialization_options
      options = {}
      options[:params] = { current_user: current_user }
      options
    end

  end
end
