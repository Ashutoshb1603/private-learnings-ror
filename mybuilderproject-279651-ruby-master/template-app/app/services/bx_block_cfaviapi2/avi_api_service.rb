module BxBlockCfaviapi2
    module AviApiService
      class << self
        require 'uri'
        require 'net/http'
  
        def get_aircaft_data_and_store
          ENV["AVI_URL"] = "https://dir.aviapages.com"
          
          url = URI("#{ENV['AVI_URL']}/api/aircraft/?features=true&images=true&ordering=-aircraft_id")
          token = "NDvsUKaAGXR0G9n7I2l0b7ivETVSXMNTjZRA"
          https = Net::HTTP.new(url.host, url.port)
          https.use_ssl = true
          request = Net::HTTP::Get.new(url)
          request['authorization'] = "Token #{token}"
          form_data = []
          request.set_form form_data, 'multipart/form-data'
          response = https.request(request)
          res = JSON.parse(response.body)
          aircrafts = []
          if res["results"].present?
            res["results"].each do |air|
              aircraft = BxBlockCatalogue::AviAircraft.find_by(aircraft_id: air["aircraft_id"])
              if aircraft.present?
                aircraft.update(
                tail_number: air["tailNumber"], aircraft_id: air["aircraft_id"], aircraft_type_name: air["aircraft_type_name"], max_passengers: air[:max_passengers], aircraft_class_name: air["aircraft_class_name"], serial_number: air["serial_number"],
                company_name: air["company_name"], company_id: air["company_id"],hot_meal: air["hot_meal"], is_for_charter: air["is_for_charter"], is_for_sale: air["is_for_sale"], 
                entertainment_system: air["entertainment_system"], medical_ramp: air["medical_ramp"], adult_critical_care: air["adult_critical_care"],pediatric_critical_care: air["pediatric_critical_care"], smoking: air["smoking"], pets_allowed: air["pets_allowed"],
                year_of_production:air["year_of_production"], manufacturer_name: air["manufacturer_name"], cabin_crew: air["cabin_crew"], lavatory: air["lavatory"], shower: air["shower"], satellite_phone: air["satellite_phone"], is_for_sale: air["is_for_sale"], 
                wireless_internet: air["wireless_internet"], owners_approval_required: air["owners_approval_required"], refurbishment_year: air["refurbishment_year"],view_360: air["view_360"], divan_seats: air["divan_seats"], beds: air["beds"], city_name: air["city_name"], slug: air["slug"], cabin_height: air["cabin_height"],cabin_length: air["cabin_length"], cabin_width: air["cabin_width"], is_active: air["is_active"],
                sleeping_places: air["sleeping_places"], country_name: air["country_name"])
  
              else
                aircraft = BxBlockCatalogue::AviAircraft.create(
                tail_number: air["tailNumber"], aircraft_id: air["aircraft_id"], aircraft_type_name: air["aircraft_type_name"], max_passengers: air[:max_passengers], aircraft_class_name: air["aircraft_class_name"], serial_number: air["serial_number"],
                company_name: air["company_name"], company_id: air["company_id"],hot_meal: air["hot_meal"], is_for_charter: air["is_for_charter"], is_for_sale: air["is_for_sale"], 
                entertainment_system: air["entertainment_system"], medical_ramp: air["medical_ramp"], adult_critical_care: air["adult_critical_care"],pediatric_critical_care: air["pediatric_critical_care"], smoking: air["smoking"], pets_allowed: air["pets_allowed"],
                year_of_production:air["year_of_production"], manufacturer_name: air["manufacturer_name"], cabin_crew: air["cabin_crew"], lavatory: air["lavatory"], shower: air["shower"], satellite_phone: air["satellite_phone"], is_for_sale: air["is_for_sale"], 
                wireless_internet: air["wireless_internet"], owners_approval_required: air["owners_approval_required"], refurbishment_year: air["refurbishment_year"],view_360: air["view_360"], divan_seats: air["divan_seats"], beds: air["beds"], city_name: air["city_name"], slug: air["slug"], cabin_height: air["cabin_height"],cabin_length: air["cabin_length"], cabin_width: air["cabin_width"], is_active: air["is_active"],
                sleeping_places: air["sleeping_places"], country_name: air["country_name"])
  
              end
            aircrafts << aircraft
              
            end
          end
          aircrafts
        end
      end
    end
  end
  