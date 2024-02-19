module BxBlockAppointmentManagement
    class TwilioController < ApplicationController
  
      def create(body)
        endpoint = "v1/Rooms"
        JSON.parse(get_response(endpoint, body, "post", "form-urlencoded", "twilio"))
      end

      def show(room_name)
        endpoint = "v1/Rooms/#{room_name}"
        JSON.parse(get_response(endpoint, "", "get", "json", "twilio"))
      end

    end
end