module BxBlockCfflexapi2
  class FlexapisController < ApplicationController
  
    def store_aircraft_data
      aircraft_data = BxBlockCfflexapi2::FlexApiService.get_aircaft_data_and_store
      render json: {message: "data is storing in Database.", data: aircraft_data}, status: :ok
    end

    def store_crew_data
      crew = BxBlockCfflexapi2::FlexApiService.get_crew_data
      render json: {message: "data is storing in Database."}, status: :ok
    end

    def store_airport_data
      airport_data = BxBlockCatalogue::AirportDataApiService.get_airport_data
      render json: {message: "data is storing in Database."}, status: :ok
    end
  end
end
