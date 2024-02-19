module BxBlockCfrdcenroutechargesapi
  module RdcEnrouteChargeApiService
    class << self

      def create_rdc_enroute_charge_data
        enroute_data = []
        BxBlockCatalogue::Aircraft.all.each do |aircraft|
          schedules = aircraft.aircraft_schedules
          schedules.each do |schedule|
            return if schedule.arrival_airport == schedule.departure_airport
            enroute_data << BxBlockCfaviaapi2::Aviapage.where(arrival_airport: schedule.arrival_airport, departure_airport: schedule.departure_airport).each{|aviapage| get_enroute_charge_response(aviapage, schedule, aircraft.aircraft_equipment.max_weight)}
          end
        end
        enroute_data
      end
        
      def get_enroute_charge_response(aviapage, schedule, weight)
        ENV['RDC_ENROUTE_URL'] = 'https://api.rdcaviation.com/enroute/api/v1/detail'
        ENV['RDC_TOKEN'] = '8247b171384076915acde75acd479d419132b28dc6a6b4698873035b1bdadbb2'
        data = {
          originAirportCode: aviapage.arrival_airport,
            destinationAirportCode: aviapage.departure_airport,
            date: schedule.arrival_date,
            mtow: weight,
            currency: "USD",
            waypoints: eval(aviapage.route)["ifr_route"]
        }
        
        headers = {
          content_type: :json,
          Authorization: "Bearer #{ENV['RDC_TOKEN']}"
        }
        
        begin
          response = RestClient.post(ENV['RDC_ENROUTE_URL'], data.to_json, headers)
          result = JSON.parse(response)
          if result["success"]["data"].present?
            res =  result["success"]["data"]
            enroute = BxBlockCfrdcenroutechargesapi::EnrouteCharge.find_by(origin_airport: res["originAirport"], destination_airport: res["destinationAirport"], date: schedule.arrival_date)
            if enroute.present?
              enroute.update(sub_total: res["subTotal"], sub_total_currency: res["subTotalCurrency"], total_distance_flown_in_km: res["totalDistanceFlownInKm"], enroute_charge_data: res["enrouteCountryCharges"], exchange_rate_data: res["exchangeRates"], information_data: res['information'])
            else
              BxBlockCfrdcenroutechargesapi::EnrouteCharge.create!(origin_airport: res["originAirport"], destination_airport: res["destinationAirport"], sub_total: res["subTotal"], sub_total_currency: res["subTotalCurrency"], total_distance_flown_in_km: res["totalDistanceFlownInKm"], enroute_charge_data: res["enrouteCountryCharges"], exchange_rate_data: res["exchangeRates"], information_data: res['information'], date: schedule.arrival_date, mtow: weight)
            end
          end
        rescue RestClient::BadRequest => e
          puts "Error: #{e.response}"
        end
      end
    end
  end
end
