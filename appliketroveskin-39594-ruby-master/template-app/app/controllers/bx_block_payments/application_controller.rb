module BxBlockPayments
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ApiHelper

    before_action :validate_json_web_token, :except => [:execute, :membership_update]
    before_action :is_freezed, :except => [:execute, :membership_update]
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def get_response(from, to, amount)
      url = "https://api.getgeoapi.com/v2/currency/convert?api_key=#{ENV["CURRENCY_API_KEY"]}&from=#{from}&to=#{to}&amount=#{amount}"
      response = ApiReader.new.call(url, "", "", "get").read_body
    end

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end
  end
end
