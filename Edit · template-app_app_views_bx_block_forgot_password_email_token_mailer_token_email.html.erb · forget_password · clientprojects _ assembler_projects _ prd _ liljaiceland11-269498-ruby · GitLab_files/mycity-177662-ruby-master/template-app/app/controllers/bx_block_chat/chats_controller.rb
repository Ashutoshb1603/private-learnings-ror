module BxBlockChat
  class ChatsController < BxBlockChat::ApplicationController
    before_action :find_chat, only: [:update, :destroy]

    def index
      chats = current_user.chats.multiple_user_chats
      render json: ::BxBlockChat::ChatOnlySerializer.new(chats, serialization_options).serializable_hash, status: :ok
    end

    def show
      chat = BxBlockChat::Chat.where(conversation_sid: params[:conversation_sid]).includes('accounts')
      if chat.present?
        render json: ::BxBlockChat::ChatShowSerializer.new(chat, serialization_options).serializable_hash, status: :ok
      else
        render json: { errors: "Chat room doesn't exist" }, status: :unprocessable_entity
      end
    end

    def create
      accounts = params[:account_ids].map{|id| AccountBlock::Account.find_by(id: id)}
      unique_name = Time.now.to_i#"#{current_user.id}_#{params[:account_ids]}"
      friendly_name = "#{params[:name]}"
      conversation = client_conversation(@client, unique_name, friendly_name)
      current_chat_participant = create_participants(conversation.sid, current_user)
      chat = BxBlockChat::Chat.create(conversation_sid: conversation.sid, name: friendly_name, chat_type: 1, image: params[:image], social_club_id: params[:social_club_id])
      if accounts.compact&.present?
        chat_participant = []
        accounts.compact&.each do |account|
          unless account.id == current_user.id
            conversation.attributes.concat({first_name: account.first_name, last_name: account.last_name, email: account.email, profile_image: account&.profile_bio&.profile_image&.url}.to_json)
            participant = create_participants(conversation.sid, account)
            chat_participant << participant if account.present?
            BxBlockChat::AccountsChatsBlock.create(account_id: account.id, chat_id: chat.id, participant_sid: participant.sid)
          end
        end
        BxBlockChat::AccountsChatsBlock.create(account_id: current_user.id, chat_id: chat.id, participant_sid: current_chat_participant.sid, is_admin: true)
      end
      render json: {data: {
        conversation_sid: conversation.sid,
        unique_name: conversation.unique_name,
        friendly_name: conversation.friendly_name,
        chat_id: chat.id,
        # attributes: conversation.attributes,
        current_chat_participant: {
          current_chat_participant_sid: current_chat_participant.sid,
          role_sid: current_chat_participant.role_sid
        },
        participant: {
          participant: chat_participant&.map{|cp| cp.sid},
          role_sid: chat_participant&.map{|cp| cp.role_sid}
        }
    }}, status: :ok
    end

    def update
      if @chat
        @chat.update(chat_update_params)
        render json: ::BxBlockChat::ChatShowSerializer.new(@chat, serialization_options).serializable_hash, status: :ok
      else
        render json: {message: "Not Found"}
      end
    end

    def destroy
      if @chat
        sid = @chat.conversation_sid
        @client.conversations.conversations(sid).delete
        @chat.destroy
        render json: ::BxBlockChat::ChatShowSerializer.new(@chat, serialization_options).serializable_hash, status: :ok
      else
        render json: {message: "Not Found"}
      end
    end

    def get_access_token
      #@client.keys.list.first.delete if @client.keys.list.count >= 110 
      render json: {token: access_token}
    end

    def access_token
      account_sid = @client.account_sid
      api_key = ENV['TWILLIO_API_KEY_SID']
      api_secret = ENV['TWILLIO_API_KEY_SECRET']

      grant = Twilio::JWT::AccessToken::ChatGrant.new
      grant.push_credential_sid = params[:is_android].to_s == "true" ? ENV['ANDROID_FCM_SID'] : ENV['IOS_FCM_SID']
      grant.service_sid = ENV['SERVICE_SID']

      video_grant = Twilio::JWT::AccessToken::VideoGrant.new
      video_grant.room = 'video room'

      token = Twilio::JWT::AccessToken.new(
          account_sid,
          api_key,
          api_secret,
          [grant, video_grant],
          identity: create_identity(current_user)
      )
      return token.to_jwt
    end

    def get_chat_media
      if params[:conversation_sid].present?
        chat = BxBlockChat::Chat.find_by(conversation_sid: params[:conversation_sid])
        render json: ::BxBlockChat::AttachmentOnlySerializer.new(chat.messages, serialization_options).serializable_hash, status: :ok
      else
        render json: {message: "No ID provided."}
      end
    end

    private

    def client_conversation(client, unique_name, friendly_name)
      client.conversations.conversations.create(unique_name: unique_name, friendly_name: friendly_name, attributes: {first_name: current_user.first_name, last_name: current_user.last_name, email: current_user.email}.to_json)
    end 

    def create_identity(account)
      "#{account.first_name}-#{account.last_name}-#{account.id}"
    end

    def chat_update_params
      params.require(:chat).permit(:name, :image)
    end

    def search_params
      params.permit(:query)
    end

    def find_chat
      @chat = Chat.find_by_id(params[:id])
      render json: {message: "Chat room is not valid or no longer exists" } unless @chat
    end

    def create_participants(conversation_sid, account)
      @client.conversations
      .conversations(conversation_sid)
      .participants
      .create(identity: create_identity(account))
    end
  end
end
