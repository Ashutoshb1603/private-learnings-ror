module BxBlockCfaviaapi2
  class AviapagesController < ApplicationController

		def get_aviapage_response(aircraft, schedule)
			url = "https://frc.aviapages.com/flight_calculator/"
			data = {
			  departure_airport: schedule.departure_airport,
			  arrival_airport: schedule.arrival_airport,
			  aircraft: aircraft.aircraft_type,
			  pax: schedule.pax.presence || 0,
			  airway_time: true,
			  airway_fuel: true,
			  airway_distance: true,
			  ifr_route: true
			}
		  
			headers = {
			  content_type: 'application/json',
			  Authorization: 'Token NDvsUKaAGXR0G9n7I2l0b7ivETVSXMNTjZRA'
			}
		  
			begin
			  response = RestClient.post(url, data.to_json, headers)
			  result = JSON.parse(response)
			  BxBlockCfaviaapi2::Aviapage.create!(
				fuel: result.try(:[], "fuel"),
				fuel_airway: result.try(:[], "fuel").try(:[], "airway"),
				fuel_airway_block: result.try(:[], "fuel").try(:[], "airway_block"),
				time: result.try(:[], "time"),
				time_airway: result.try(:[], "time").try(:[], "airway"),
				route: result.try(:[], "route"),
				ifr_route: result.try(:[], "route").try(:[], "ifr_route"),
				airport: result.try(:[], "airport"),
				arrival_airport: result.try(:[], "airport").try(:[], "arrival_airport"),
				departure_airport: result.try(:[], "airport").try(:[], "departure_airport"),
				aircraft: result.try(:[], "aircraft"),
				distance: result.try(:[], "distance"),
				distance_airway: result.try(:[], "distance").try(:[], "airway")
			  )
			rescue RestClient::BadRequest => e
			  puts "Error: #{e.response}"
			end
		  end
		  
		  def create_aviapages
			BxBlockCfaviaapi2::Aviapage.destroy_all
			BxBlockCatalogue::Aircraft.all.each do |aircraft|
			  schedules = aircraft.aircraft_schedules
			  schedules.each { |schedule| get_aviapage_response(aircraft, schedule) }
			end
		  end

  end
end
