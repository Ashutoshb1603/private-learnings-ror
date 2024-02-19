# frozen_string_literal: true

module BuilderJsonWebToken
  module JsonWebTokenValidation
    ERROR_CLASSES = [
      JWT::DecodeError,
      JWT::ExpiredSignature,
    ].freeze

    private

    def validate_json_web_token
      token = request.headers[:token] || params[:token]
      begin
        @token = JsonWebToken.decode(token)
        account = AccountBlock::Account.find_by(id: @token&.id) unless @token&.account_type == "AdminAccount"
        account = AdminUser.find_by(id: @token&.id) if @token&.account_type == "AdminAccount"
        if !account.present?
          message = "Account deleted."
          return render json: { errors: {message: message, token: message}},
          status: :unauthorized
        elsif account.jwt_token != @token&.jwt_token
          message = "Someone else logged in using your account! Login Again to continue."
          message = "Logged out. Please Login again!" if !account.jwt_token
          return render json: { errors: {message: message, token: message}},
          status: :unauthorized
        end
      rescue *ERROR_CLASSES => exception
        handle_exception exception
      end
    end

    def handle_exception(exception)
      # order matters here
      # JWT::ExpiredSignature appears to be a subclass of JWT::DecodeError
      case exception
      when JWT::ExpiredSignature
        return render json: { errors: {message: 'Token has Expired', token: 'Token has Expired'}},
          status: :unauthorized
      when JWT::DecodeError
        return render json: { errors: {message: 'Invalid token', token: 'Invalid token'}},
          status: :bad_request
      end
    end
  end
end
