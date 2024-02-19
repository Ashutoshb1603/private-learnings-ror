module BxBlockAppointmentManagement
  class AcuityController < ApplicationController
        
    def show(id)
      endpoint = "api/v1/appointments/#{id}"
      appointments = JSON.parse(get_response(endpoint))
    end

    def cancel(id, body)
      endpoint = "api/v1/appointments/#{id}/cancel"
      appointments = JSON.parse(get_response(endpoint, body, "put", "json"))
    end

    def reschedule(id, body)
      endpoint = "api/v1/appointments/#{id}/reschedule"
      appointments = JSON.parse(get_response(endpoint, body, "put", "json"))
    end

    def appointment_types
      endpoint = "api/v1/appointment-types"
      appointments = JSON.parse(get_response(endpoint))
    end

    def therapists
      endpoint = "api/v1/calendars"
      therapists = JSON.parse(get_response(endpoint))
    end

    def create(body)
      endpoint = "api/v1/appointments"
      JSON.parse(get_response(endpoint, body, "post", "json"))
    end

    def customer_appointments(email)
      endpoint = "api/v1/appointments?email=#{email}&showall=true"
      appointments = JSON.parse(get_response(endpoint))
    end

    def therapist_appointments(calendarId)
      endpoint = "api/v1/appointments"
      appointments = JSON.parse(get_response(endpoint))
      therapist_appointments  = []

      appointments.each do |appointment|
        therapist_appointments << appointment if appointment["calendarID"].to_s == calendarId
      end

      therapist_appointments
    end

    def index(calendarID="", minDate, maxDate)
      minDate = Time.now.strftime("%D") if minDate.nil?
      maxDate = Time.now.strftime("%D") if maxDate.nil?
      endpoint = "api/v1/appointments?minDate=#{minDate}&maxDate=#{maxDate}&direction=ASC"
      endpoint += "&calendarID=#{calendarID}" if calendarID != ""
      appointments = JSON.parse(get_response(endpoint))
    end

    def available_dates(calendarId, appointmentTypeID, month)
      endpoint = "api/v1/availability/dates?appointmentTypeID=#{appointmentTypeID}&month=#{month}&calendarID=#{calendarId}"
      dates = JSON.parse(get_response(endpoint))
    end

    def available_times(calendarId, appointmentTypeID, date)
      endpoint = "api/v1/availability/times?appointmentTypeID=#{appointmentTypeID}&date=#{date}&calendarID=#{calendarId}"
      dates = JSON.parse(get_response(endpoint))
    end

  end
end