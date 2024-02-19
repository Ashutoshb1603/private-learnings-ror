module BxBlockSocialClubs
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ActiveStorage::SetCurrent

    # before_action :validate_json_web_token, except: [:index, :approved_social_clubs, :approved_events, :show]

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
    end

    def current_user
      @current_user ||= AccountBlock::Account.find(@token.id) if @token.present?
      return render json: {status: 401, error: 'Invalid token' }, status: 401 if ((@current_user.blank? || !@current_user.activated) || @token.token_type == 'signup')
    end

    def client_conversation(client, unique_name, friendly_name)
      begin
        client.conversations.conversations.create(unique_name: unique_name, friendly_name: friendly_name, attributes: {first_name: @current_user.first_name, last_name: @current_user.last_name, email: @current_user.email}.to_json)
      rescue
        return nil
      end
    end 

    def create_identity(account)
      "#{account.first_name}-#{account.last_name}-#{account.id}"
    end

		def create_participants(conversation_sid, account)
      begin
        @client.conversations
        .conversations(conversation_sid)
        .participants
        .create(identity: create_identity(account))
      rescue
        return nil
      end
    end

		def create_client
      account_sid =  ENV['TWILLIO_ACCOUNT_SID']
      auth_token = ENV['TWILLIO_AUTH_TOKEN']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
    end
  end
end