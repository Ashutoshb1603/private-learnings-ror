module BxBlockKlaviyointegration
    class KlaviyoController < ApplicationController
        include ApiHelper
        @@api_key = ENV['KLAVIYO_API_KEY']
        def create_list(list_name)
            endpoint = "v2/lists?api_key=#{@@api_key}"
            body = "list_name=#{list_name}"
            get_response(endpoint, body, "post", "form-data")
        end

        def get_list
            endpoint = "v2/lists?api_key=#{@@api_key}"
            get_response(endpoint)
        end

        def create_subscriber(list_id, email_ids_hash)
            endpoint = "v2/list/#{list_id}/members?api_key=#{@@api_key}"
            body = Hash.new
            body["profiles"] = [email_ids_hash]           #Hash format {"email":"test@gmail.com"}
            get_response(endpoint, body, "post")
        end

        def unsubscribe(list_id, email)
            endpoint = "v2/list/#{list_id}/subscribe?api_key=#{@@api_key}"
            body = Hash.new
            body["emails"] = [email]           
            get_response(endpoint, body, "delete")
        end

        private
        def get_response(endpoint, body="", type="get", data_type="json")
            url = "https://a.klaviyo.com/api/" + endpoint
            request = Hash.new
            request["Accept"] = "application/json"
            request["Content-Type"] = "application/json"
            request["Content-Type"] = "application/x-www-form-urlencoded" if data_type == "form-data"
            ApiReader.new.call(url, request, body, type).read_body
        end
    end
end