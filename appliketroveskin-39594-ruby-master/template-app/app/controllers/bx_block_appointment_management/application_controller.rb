module BxBlockAppointmentManagement
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ApiHelper

    before_action :validate_json_web_token
    before_action :is_freezed

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def get_response(endpoint, body="", api_type="get", content_type="", domain="acuity")
      url = "https://acuityscheduling.com/" + endpoint if domain == "acuity"
      url = "https://video.twilio.com/" + endpoint if domain == "twilio"
      request_params = Hash.new
      request_params["Content-Type"] = "application/x-www-form-urlencoded" if content_type == "form-urlencoded"
      request_params["Content-Type"] = "application/json" if content_type == "json"
      request_params["Authorization"] = domain == "acuity" ? ENV["ACUITY_AUTH_KEY"] : ENV["TWILIO_AUTH_KEY"]
      ApiReader.new.call(url, request_params, body, api_type).read_body
    end

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end
  end
end
