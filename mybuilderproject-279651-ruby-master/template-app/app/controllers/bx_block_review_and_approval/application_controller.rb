module BxBlockReviewAndApproval
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token

    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render json: {"errors" => ["Record not found"]}, status: :not_found
    end

    def current_user
      @current_user = AccountBlock::Account.find(@token.id)
    rescue ActiveRecord::RecordNotFound => e
      render json: {errors: [
        {message: "Please login again."}
      ]}, status: :unprocessable_entity
    end
  end
end
