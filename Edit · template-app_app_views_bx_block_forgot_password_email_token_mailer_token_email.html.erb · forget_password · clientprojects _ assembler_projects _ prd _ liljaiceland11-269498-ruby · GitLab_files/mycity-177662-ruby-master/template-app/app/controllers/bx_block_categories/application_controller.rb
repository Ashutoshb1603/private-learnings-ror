module BxBlockCategories
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    before_action :validate_json_web_token, except: [:index]
    before_action :current_user, except: [:index]
    before_action :page_from_params
    
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
    end

    def current_user
      @current_user ||= AccountBlock::Account.find_by(id: @token.id)
      return render json: {status: 422, error: 'Invalid token' }, status: 422 if @current_user.blank? || !@current_user.activated
    end
  end
end
