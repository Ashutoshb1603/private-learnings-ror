module BxBlockAdmin
  class ContentsController < BxBlockAdmin::ApplicationController
  	include BuilderJsonWebToken::JsonWebTokenValidation
    # before_action :validate_json_web_token
    include ActiveStorage::SetCurrent

    def contact_us
      content = BxBlockAdmin::ContactUs.new(contact_us_params)
      if content.save
        render json: BxBlockAdmins::ContactUsSerializer.new(content, meta: {
                  message: "Contact Us Query"
                }).serializable_hash, status: :ok
      else
        render json: {errors: content.errors},
               status: :unprocessable_entity
      end
    end


    def terms_and_conditions
      if request.headers[:token].present?
        validate_json_web_token
        current_user
      end

      content = BxBlockAdmin::TermsAndCondition.all
      render json: BxBlockAdmins::TermsAndConditionSerializer.new(content, serialization_options).serializable_hash, status: :ok
    end


    private 

    def contact_us_params
      params.require(:contact_us).permit(:description, :name, :email)
    end

    def current_user
      @current_user ||= AccountBlock::Account.find_by(id: @token.id)
    end

    def serialization_options
      options = {}
      options[:params] = { current_user: @current_user, language: params[:language] }
      options
    end

  end
end
