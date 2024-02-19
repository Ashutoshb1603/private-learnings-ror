module BxBlockHiddenPlaces
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

      def not_found
        render :json => {
          'errors' => [
            'Record not found'
          ]
        }, :status => :not_found
      end

      def check_account_activated
        @current_user ||= AccountBlock::Account.find_by_id(@token&.id)
        return render json: {status: 401, error: 'Invalid token' }, status: 401 if ((@current_user.blank? || !@current_user.activated) || @token.token_type == 'signup')
      end
  end
end


