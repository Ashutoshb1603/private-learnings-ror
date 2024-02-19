module BxBlockCommunityforum
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include Pagy::Backend
    
    before_action :validate_json_web_token
    before_action :is_freezed
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end
  end
end
