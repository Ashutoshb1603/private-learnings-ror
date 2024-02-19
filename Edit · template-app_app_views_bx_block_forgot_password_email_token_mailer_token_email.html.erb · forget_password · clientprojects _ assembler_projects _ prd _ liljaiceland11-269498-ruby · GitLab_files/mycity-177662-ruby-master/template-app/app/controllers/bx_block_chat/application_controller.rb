module BxBlockChat
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, :create_client

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
    end

    def current_user
      begin
        @current_user = AccountBlock::Account.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors: [
          {message: 'Please login again.'},
        ]}, status: :unprocessable_entity
      end
    end

    def serialization_options
      { params: { host: request.protocol + request.host_with_port, client:  create_client} }
    end

    def create_client
      account_sid =  ENV['TWILLIO_ACCOUNT_SID']
      auth_token = ENV['TWILLIO_AUTH_TOKEN']
      @client = Twilio::REST::Client.new(account_sid, auth_token)
    end
  end
end
