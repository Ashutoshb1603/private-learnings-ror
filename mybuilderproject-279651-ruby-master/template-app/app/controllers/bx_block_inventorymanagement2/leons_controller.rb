module BxBlockInventorymanagement2
  class LeonsController < ApplicationController
    def authenticate_user
      redirect_to 'https://man.sandbox.leon.aero/oauth2/code/authorize/?response_type=code&client_id=63b5d45ea3f3d8.36634412&redirect_uri=https://26c3-15-206-64-22.ngrok.io/bx_block_inventorymanagement2/leons/leon_auth_data&scope[0]=GRAPHQL_AIRCRAFT_AVAILABILITY&scope[1]=GRAPHQL_ACFT&scope[2]=GRAPHQL_OPERATOR&scope[3]=GRAPHQL_AIRPORT', target: :blank
    end

    def leon_auth_data
      if params[:code].present?
        url = 'https://man.sandbox.leon.aero/oauth2/code/token/'
        response = RestClient.post(url, {grant_type: 'authorization_code', client_id: '63b5d45ea3f3d8.36634412', client_secret: '74d2097d27f880f27fc2e3d08e354753670cba6204053ce3110d2c12ab39aef2', redirect_uri: 'https://26c3-15-206-64-22.ngrok.io/bx_block_inventorymanagement2/leons/leon_auth_data', code: params[:code]})
        account = AccountBlock::Account.find_by(leon_client_id: '63b5d45ea3f3d8.36634412')
        account.update_columns(leon_access_token: JSON.parse(response.body)["access_token"], leon_refresh_token: JSON.parse(response.body)["refresh_token"],leon_expire_time: Time.now.utc + 30.minutes) if account.present?
        request =  { "query": "{ aircraftAvailability { availabilityList(startTime: \"2023-03-24\", registration: null) { aircraft { aircraftNid acftTypeId acftType { acftTypeId icao iata easa name shortName typeName acKind isAircraft isHelicopter } operator { oprNid oprId name } category { categoryNid categoryName hierarchy } registration acftTypeName } recordList { location { locationNid name } } } }}"}
        data = RestClient.post("https://man.sandbox.leon.aero/api/graphql/", request, headers={:Authorization => "Bearer #{account.leon_access_token}"})
        aircraft_availability = JSON.parse(data)
          aircraft_availability["data"]["aircraftAvailability"]["availabilityList"].each do |aircraft|
            category = BxBlockCategories::Category.find_or_create_by(name: aircraft["aircraft"]["category"]["categoryName"]) if aircraft["aircraft"]["category"].present?
            operator = BxBlockCatalogue::Operator.find_or_create_by(opr_nid:  aircraft["aircraft"]["operator"]["oprNid"], name: aircraft["aircraft"]["operator"]["name"], oprcode: aircraft["aircraft"]["operator"]["oprId"]) if aircraft["aircraft"]["operator"].present?
            aircraft = BxBlockCatalogue::Aircraft.find_or_create_by(tail_number: aircraft["aircraft"]["aircraftNid"], aircraft_type: aircraft["aircraft"]["acftTypeId"], type_name:  aircraft["aircraft"]["acftType"]["name"], aircraft_base_icao: aircraft["aircraft"]["acftType"]["icao"], aircraft_base_iata: aircraft["aircraft"]["acftType"]["iata"], aircraft_base_easa: aircraft["aircraft"]["acftType"]["easa"], is_aircraft: aircraft["aircraft"]["acftType"]["isAircraft"], is_helicopter: aircraft["aircraft"]["acftType"]["isHelicopter"], data_source: "leon", category_id: category&.id, operator_id: operator&.id)
          end
        render json:data
      end
    end
  end
end
