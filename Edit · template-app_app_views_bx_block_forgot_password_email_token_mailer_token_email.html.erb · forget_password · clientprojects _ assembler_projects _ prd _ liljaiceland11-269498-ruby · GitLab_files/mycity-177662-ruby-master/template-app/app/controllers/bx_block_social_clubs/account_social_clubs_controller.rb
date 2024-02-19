module BxBlockSocialClubs
    class AccountSocialClubsController < BxBlockSocialClubs::ApplicationController
        before_action :validate_json_web_token, except: [:index]
        before_action :current_user, except: [:index]
        before_action :validate_bolcked_user, only: [:create, :delete_participants] 
        before_action :page_from_params       
        before_action :create_client, only: [:create_participants, :create, :delete_participants]        

        def index
            @social_club_accounts = BxBlockSocialClubs::AccountSocialClub.joins(:account).where(social_club_id: params[:social_club_id])
            
            if params[:search].present?
              @social_club_accounts = @social_club_accounts.where("lower(accounts.full_name) ILIKE ?", "%#{params[:search]}%")&.distinct
            end

            if @social_club_accounts.present?
              render json: BxBlockSocialClubs::AccountSocialClubsSerializer.new(@social_club_accounts.page(@page).per(@per_page))
                .serializable_hash, status: :ok
            else
              render json: {errors: "No participants yet" },
                  status: :unprocessable_entity
            end
        end

        def create
            @club = BxBlockSocialClubs::SocialClub.find(params[:social_club_id])
            if @club.approved?
                @club_user = @current_user.account_social_clubs.new(social_club_id: @club.id)
                if @club_user.save
                    create_group_chat_participants(@club)
                    send_notification_to_user(@club_user, @club)
                    render json: BxBlockSocialClubs::AccountSocialClubsSerializer.new(@club_user,
                                meta: {message: "Thank you for registering in #{@club.name} club"})
                                .serializable_hash, status: :created
                else
                    render json: {errors: @club_user.errors.full_messages },
                        status: :unprocessable_entity
                end
            else
                render json: {message: "This club is not approved by the admin yet."}, status: :unprocessable_entity
            end
        end

        def delete_participants
            @social_club = @current_user.social_clubs&.find_by(id: params[:social_club_id])
            club_participants = @social_club.account_social_clubs.where(account_id: params[:ids]) if @social_club
            chat_participants = @social_club.chat&.accounts_chats.where(account_id: params[:ids]) if @social_club.chat
            if club_participants.destroy_all
                if chat_participants.present?
                    sid = @social_club.chat&.conversation_sid
                    chat_participants.each do |participant|
                        participant_sid = participant.participant_sid
                        chat_participant = @client.conversations.conversations(sid).participants(participant_sid).fetch rescue nil
                        chat_participant.delete if chat_participant
                    end
                    chat_participants.destroy_all
                end
                render json: {message: "Participants removed from club."}
			else
				render json: {errors: "Participant not found" },
					status: :unprocessable_entity 
			end
        end

        def send_notification_to_user(club_user, club)
            BxBlockEmailnotifications::AdminNotificationMailer.social_club_joined(club.name, club.account&.email, club_user).deliver_later
        end

        def create_group_chat_participants(club)
            conversation_sid = club.chat&.conversation_sid
            if club.chat
                added_participant = create_participants(conversation_sid, @current_user)
                BxBlockChat::AccountsChatsBlock.create(account_id: @current_user.id, chat_id: club.chat&.id, participant_sid: added_participant.sid)
            end
        end

        private

        def validate_bolcked_user
          if @current_user.is_blacklisted?
            return render json: {status: 401, error: 'You are not allowed to perform. Your account was blocked by admin'}, status: 401
          end
        end
    end
end
