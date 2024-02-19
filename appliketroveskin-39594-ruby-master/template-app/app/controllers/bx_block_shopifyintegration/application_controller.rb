module BxBlockShopifyintegration
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ApiHelper
    
    before_action :validate_json_web_token
    before_action :is_freezed
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    private

    def not_found
      render :json => {'errors' => {"message" =>'Record not found'}}, :status => :not_found
    end

    def location
      @location = "Ireland"
      # @location = Geocoder.search([@params['latitude'], @params['longitude']]).first.country if @params.present?
      @location = @params[:country] if @params[:country].present?
      @location
    end

    def get_response(endpoint, body="", api_type="get", content_type="", paginate=false, location="")
      @location = @params[:country] || "Ireland"
      @location = location if location.present?
      host_name = @location.downcase=="ireland" ? ENV['SHOPIFY_HOSTNAME'] : ENV['SHOPIFY_HOSTNAME_UK']
      password = @location.downcase=="ireland" ? ENV['SHOPIFY_ACCESS_TOKEN'] : ENV['SHOPIFY_ACCESS_TOKEN_UK']
      if (endpoint.include?('blog') || endpoint.include?('article'))
        host_name = ENV['SHOPIFY_HOSTNAME']
        password = ENV['SHOPIFY_ACCESS_TOKEN']
      end
      url = "https://#{host_name}.myshopify.com" + endpoint
      request_params = Hash.new
      request_params["Content-Type"] = "application/json" if content_type == "json"
      request_params["X-Shopify-Access-Token"] = password
      if paginate
        response = ApiReader.new.call(url, request_params, body, api_type)
        link = response["link"]
        response_json = JSON.parse(response.read_body)
        response_json["prev"] = link.present? && link.include?("prev") ? link.split("page_info").second.split(">\;").first[1..-1] : ""
        response_json["next"] = link.present? && link.include?("next") ? link.split("page_info").last.split(">\;").first[1..-1] : ""
        JSON.generate(response_json)
      else
        response = ApiReader.new.call(url, request_params, body, api_type)
        (response.kind_of? Net::HTTPSeeOther) ? JSON.parse(response.to_json) : response.read_body
      end
    end

    def current_user
      begin
        @current_user = AccountBlock::Account.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors:
            {message: 'Please login again.'}
        }, status: :unprocessable_entity
      end
    end
  end
end

