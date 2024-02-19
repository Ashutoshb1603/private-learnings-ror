module BxBlockCatalogue
  module AirportDataApiService
    class << self
    	require 'uri'
      require 'net/http'

      def get_airport_data
      	ENV['AIRPORTDATA_APIKEY'] = "91754B6CBC5F5856"
      	url = URI("https://api.airportdata.com/regions?apikey=#{ENV['AIRPORTDATA_APIKEY']}")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        response = https.request(request)
        region_res = JSON.parse(response.body)
        region_res = region_res["regions"]
        if region_res.present?
        	region_res.each do |region|
      			url = URI("https://api.airportdata.com/countries?apikey=#{ENV['AIRPORTDATA_APIKEY']}&region_id=#{region['region_id']}")
      		  https = Net::HTTP.new(url.host, url.port)
      		  https.use_ssl = true
      		  request = Net::HTTP::Get.new(url)
      		  response = https.request(request)
      		  country_res = JSON.parse(response.body)
      		  country_res = country_res["countries"]
      		  if country_res.present?
      		  	country_res.each do |country|
	    		  		url = URI("https://api.airportdata.com/airports?apikey=#{ENV['AIRPORTDATA_APIKEY']}&country_id=#{country['country_id']}")
	    		  	  https = Net::HTTP.new(url.host, url.port)
	    		  	  https.use_ssl = true
	    		  	  request = Net::HTTP::Get.new(url)
	    		  	  response = https.request(request)
	    		  	  airportdata_res = JSON.parse(response.body)
	    		  	  airportdata_res = airportdata_res["airports"]
	    		  	  if airportdata_res.present?
	    		  	  	airportdata_res.each do |airport|
	    		  	  		air = BxBlockCatalogue::Airport.find_or_create_by(iata: airport["iata"], icao: airport["icao"])
	    		  	  		air.update("faa": airport["faa"], "airport_name": airport["airport_name"], "city": airport["city"], "subdivision_name": airport["subdivision_name"], "country_name": airport["country_name"], "iso_country_name": airport["iso_country_name"], "airport_of_entry": airport["airport_of_entry"], "last_edited": airport["Last_Edited"])
	    		  	  	end
	    		  	  end
      		  	end
      		  end
        	end
        end
      end
    end
  end
end