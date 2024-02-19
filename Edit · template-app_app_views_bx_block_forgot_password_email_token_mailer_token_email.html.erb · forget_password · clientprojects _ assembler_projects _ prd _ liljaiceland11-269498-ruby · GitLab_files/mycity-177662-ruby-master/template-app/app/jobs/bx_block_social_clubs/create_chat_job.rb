module BxBlockSocialClubs
  class CreateChatJob < ApplicationJob
    queue_as :default
		before_perform :create_client

    def perform(social_club, current_user)
      unique_name = Time.now.to_i#"#{current_user.id}_#{params[:account_ids]}"
      friendly_name = social_club.name
      conversation = client_conversation(@client, unique_name, friendly_name, current_user)
			message_push_notification(@client)
      added_participant = create_participants(@client, conversation.sid, current_user)
      chat = BxBlockChat::Chat.create(conversation_sid: conversation.sid, name: friendly_name, chat_type: 1, social_club_id: social_club.id)
      BxBlockChat::AccountsChatsBlock.create(account_id: current_user.id, chat_id: chat.id, is_admin: true, participant_sid: added_participant.sid) if chat

      send_notification_to_user(social_club)
    end

		def create_client
      account_sid =  ENV['TWILLIO_ACCOUNT_SID']
      auth_token = ENV['TWILLIO_AUTH_TOKEN']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
    end

    def send_notification_to_user(social_club)
      interest_ids = social_club.interests&.pluck(:id)
      accounts_with_interest = AccountBlock::Account.left_outer_joins(accounts_interests: :interest).where(accounts_interests: {interests: {id: interest_ids}})&.pluck(:email) if interest_ids.present?
      
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
  end
end