module BxBlockInventorymanagement2
    class FlightsController < ApplicationController
		# include Sidekiq::Worker

        def get_flights
            url = "https://test.fl3xx.com/api/external/flight/flights?from=2023-01-26&timeZone=UTC&to=2023-01-28&include=ALL"
            response = RestClient.get(url,  {content_type: 'application/json',  "x-auth-token": 'zXtCivp4_IIjTB2xxNIYOR5Pl5tV12CL'})
            render json:response
        end

		def get_quote_bookings
			url = "https://test.fl3xx.com/api/external/quote/bookings?lastRequest=2023-01-17T17:00"
			response = RestClient.get(url,  {content_type: 'application/json',  "x-auth-token": 'zXtCivp4_IIjTB2xxNIYOR5Pl5tV12CL'})
			render json:response
		end

	

	
	
	end
end