module BxBlockCfflexapi2
  module FlexApiService
    class << self
      require 'uri'
      require 'net/http'

      def get_env_var
        ENV["FLEX_URL"] = "https://test.fl3xx.com"
        ENV["FLEX_EMAIL"] = "ferhankaka@hotmail.com"
        ENV["FLEX_PASSWORD"] = "Fl3Xx-2320"
        ENV["FLEX_AUTH_TOKEN"] = "iB-YfHt0rYZgpKdIbDM6_Nyuzcda7J5U"
      end

      def api_call(url)
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request["x-auth-token"] = ENV["FLEX_AUTH_TOKEN"]
        form_data = []
        request.set_form form_data, 'multipart/form-data'
        response = https.request(request)
        res = JSON.parse(response.body)
      end

      def get_crew_data
        get_env_var
        #this is temporary airport codes, wll change it once get airport data
        airport_codes = ["LOWW", "KLAX", "LEMD", "EDDM", "EDDS"]
        airport_codes.each do |airport_code|
          url = URI("#{ENV['FLEX_URL']}/api/external/airports/#{airport_code}/crew")
          res = api_call(url)
          res.each do |data|
            crew = BxBlockCatalogue::Crew.find_or_create_by(flex_crew_id: data["id"])
            crew.update(first_name: data["firstName"], middle_name: data["middleName"], last_name: data["lastName"], account_name: data["accountName"], nick_name: data["nickname"], pilot: data["pilot"], status: data["status"], job_title: data["jobTitle"], weight: data["weight"], height: data["height"], personnel_number: data["personnelNumber"], ical_calendar_link: data["icalCalendarLink"], salutation: data["salutation"], logname: data["logname"], fuzzy_search: data["fuzzySearch"], notes: data["notes"], staffing_plan: data["staffingPlan"], employed_since: data["employedSince"], accountExpires: data["accountExpires"], birth_date: data["birthDate"], birth_place: data["birthPlace"], birth_state: data["birthState"], staff: data["staff"], gender: data["gender"], employment_type: data["employmentType"], last_sanctions_date: data["lastSanctionsDate"], allowance: data["allowance"], allowance_domestic: data["allowanceDomestic"], background_color: data["backgroundColor"], catering: data["catering"], commercial_comment: data["commercialComment"], dca: data["dca"], disable_dp_calculation: data["disableDpCalculation"], disable_ft_fdp_calculation: data["disableFtFdpCalculation"], drug_alc: data["drugAlc"], employed_until: data["employedUntil"], has_accidents: data["hasAccidents"], has_incidents: data["hasIncidents"], important: data["important"], integration: data["integration"], interest: data["interest"], maintenance_controller: data["maintenanceController"], master_crew_list: data["masterCrewList"], max_block_hours_per_month: data["maxBlockHoursPerMonth"], multi_crew_limitation: data["multiCrewLimitation"], sifl_type: data["siflType"], upload_to_argus: data["uploadToArgus"], upload_to_wywern: data["uploadToWywern"], use_custom_footer: data["useCustomFooter"], airport_code: data["airport_code"])
            crew.update(nationality_name: data["nationality"]["name"], nationality_iso2: data["nationality"]["iso2"], nationality_continent: data["nationality"]["continent"], nationality_intname: data["nationality"]["intname"], nationality_capital: data["nationality"]["capital"], nationality_iso3: data["nationality"]["iso3"], nationality_ioc: data["nationality"]["ioc"], nationality_domain: data["nationality"]["domain"], nationality_currency_code: data["nationality"]["currencyCode"], nationality_phone: data["nationality"]["phone"]) if data["nationality"].present?
            crew.update(home_airport_name: data["homeAirport"]["name"], home_airport_icao: data["homeAirport"]["icao"],home_airport_iata: data["homeAirport"]["iata"], home_airport_faa: data["homeAirport"]["faa"],home_airport_local_identifier: data["homeAirport"]["localIdentifier"], home_airport_timezone: data["homeAirport"]["timeZone"]) if data["homeAirport"].present?
            if data["roles"].present?
              crew.crew_roles.delete_all
              data["roles"].each do |role|
                crew.crew_roles.create(role_id: role["id"], role_type: role["type"], mandatory_id: role["mandatoryId"], label: role["label"], role_order: role["order"], filter_id: role["filterId"], to_display: role[:toDisplay], roster_filter: role["rosterFilter"])
              end
            end
            if data["aircrafts"].present?
              crew.crew_aircrafts.delete_all
              data["aircrafts"].each do |aircraft|
                crew.crew_aircrafts.create(aircraft_name: aircraft["aircraftName"], registration: aircraft["registration"], status: aircraft["status"], last_warning: aircraft["lastWarning"], first_warning: aircraft["firstWarning"])
              end
            end
            if data["contacts"].present?
              crew.crew_contacts.delete_all
              data["contacts"].each do |contact|
                crew.crew_contacts.create(flex_contact_id: contact["id"], data: contact["data"], contact_type: contact["type"], mains: contact["main"], deleted: contact["deleted"])
              end
            end
            crew.crew_accounts.where(default_account: true).delete_all
            crew.crew_accounts.create(default_account: true, name: data["defaultAccount"]["name"], status: data["defaultAccount"]["status"], account_number: data["defaultAccount"]["accountNumber"]) if data["defaultAccount"].present?
            if data["accounts"].present?
              crew.crew_accounts.where(default_account: false).delete_all
              data["accounts"].each do |account|
                crew.crew_accounts.create(name: account["name"], status: account["status"], account_number: account["accountNumber"])
              end
            end
            if data["preferences"].present?
              crew.crew_preferences.delete_all
              data["preferences"].each do |preference|
                pref = crew.crew_preferences.create(description: preference["description"])
                pref.update(template_name: preference["template"]["name"], order: preference["template"]["order"], template_show_in_pax: preference["template"]["showInPax"], template_show_in_catering: preference["template"]["showInCatering"], template_show_in_sales: preference["template"]["showInSales"], template_show_as_important: preference["template"]["showAsImportant"]) if preference["template"].present?
              end
            end
          end
        end
      end

      def get_aircaft_data_and_store
        get_env_var        
        url = URI("#{ENV['FLEX_URL']}/api/external/aircraft")
        res = api_call(url)
        aircrafts = []
        res.each do |air|
          aircraft = BxBlockCatalogue::Aircraft.find_by(tail_number: air["tailNumber"])
          category = BxBlockCategories::Category.find_or_create_by(name: air["category"])
          if aircraft.present?
            aircraft.update(tail_number: air["tailNumber"], aircraft_type: air["type"], model: air["model"], type_name: air[:typeName], homebase: air["homebase"], wing_span: air["wingSpan"], max_fuel: air["maxFuel"],
              external_length: air["externalLength"], external_height: air["externalHeight"], cabin_height: air["cabinHeight"],
              cabin_length:air["cabinLength"], cabin_width: air["cabinWidth"], category_id: category&.id, flight_number_token: air["flightNumberToken"], subcharter: air["subcharter"], cargo: air["cargo"], ambulance: air["ambulance"], 
              type_rating: air["typeRating"], type_of_use: air["typeOfUse"], number_of_seats: air["numberOfSeats"],
              cabin_crew: air["layout"]["cabinCrew"], flight_crew: air["layout"]["flightCrew"], onboard_engineer: air["layout"]["onboardEngineer"])

            if air["equipment"].present?
              air_eq = aircraft.aircraft_equipment.update(v110: air["equipment"]["v110"], v230: air["equipment"]["v230"], headsets: air["equipment"]["headsets"], tv: air["equipment"]["tv"], cd_dvd: air["equipment"]["cd_dvd"], wifi: air["equipment"]["wifi"], sat_phone: air["equipment"]["satPhone"], sat_tv: air["equipment"]["satTv"], entertainment_system: air["equipment"]["entertainmentSystem"], lavatory: air["equipment"]["lavatory"], enclosed_lavatory: air["equipment"]["enclosedLavatory"], coffee_pot: air["equipment"]["coffeePot"], espresso: air["equipment"]["espresso"], ice_bin: air["equipment"]["iceBin"], microwave_oven: air["equipment"]["microwaveOven"], warming_oven: air["equipment"]["warmingOven"], smoking_allowed: air["equipment"]["smokingAllowed"], pets_allowed: air["equipment"]["petsAllowed"], baggage_volume: air["equipment"]["baggageVolume"], ski_tube: air["equipment"]["skiTube"], golf_bags: air["equipment"]["golfBags"], standard_suitcases: air["equipment"]["standardSuitcases"], max_weight: air["equipment"]["maxWeight"])
            end

            if air["links"].present?
              aircraft.aircraft_links.delete_all
              air["links"].each do |link|
                air_links = aircraft.aircraft_links.create(rel: link["rel"], link_url: link["href"])
                if air_links.rel == "picture"
                  url = URI(air_links.link_url)
                  url = URI("#{ENV['FLEX_URL']}"+url.request_uri)
                  https = Net::HTTP.new(url.host, url.port)
                  https.use_ssl = true
                  request = Net::HTTP::Get.new(url)
                  request["x-auth-token"] = ENV["FLEX_AUTH_TOKEN"]
                  form_data = []
                  request.set_form form_data, 'multipart/form-data'
                  response = https.request(request)
                  response.body
                  file = File.open('public/image.jpg', 'wb') do |f|
                    f.write(response.body)
                  end
                  downloaded_image = open("public/image.jpg")
                  air_links.picture.attach(io: downloaded_image, filename: "air_image")
                end
                if air_links.rel == "schedule"
                  url = URI(air_links.link_url)
                  url = URI("#{ENV['FLEX_URL']}"+url.request_uri)
                  res = api_call(url)
                  if res.present?
                    res.each do |sch|
                      schedule = aircraft.aircraft_schedules.find_or_create_by(schedule_id: sch["id"])
                      schedule.update(departure_airport: sch["departureAirport"], arrival_airport: sch["arrivalAirport"], arrival_date: sch["arrivalDate"], arrival_date_utc: sch["arrivalDateUTC"], departure_date: sch["departureDate"], departure_date_utc: sch["departureDateUTC"], pax: sch["pax"], trip_number: sch["tripNumber"], workflow: sch["workflow"], fpl_type: sch["fplType"], workflow_custom_name: sch["workflowCustomName"])
                    end
                  end
                end
              end
            end

            if air["keyAccountManager"].present?
              air_account_manager = aircraft.aircraft_account_manager.update(
                                                  external_reference: air["keyAccountManager"]["externalReference"],
                                                  first_name: air["keyAccountManager"]["firstName"],
                                                  last_name: air["keyAccountManager"]["lastName"],
                                                  log_name: air["keyAccountManager"]["logName"],
                                                  gender: air["keyAccountManager"]["gender"],
                                                  status: air["keyAccountManager"]["status"],
                                                  salutation: air["keyAccountManager"]["salutation"],
                                                  internal_id: air["keyAccountManager"]["internalId"])
            end
          else
            aircraft = BxBlockCatalogue::Aircraft.create(tail_number: air["tailNumber"], aircraft_type: air["type"], model: air["model"],  type_name: air[:typeName], homebase: air["homebase"], wing_span: air["wingSpan"], max_fuel: air["maxFuel"],
              external_length: air["externalLength"], external_height: air["externalHeight"], cabin_height: air["cabinHeight"],
              cabin_length:air["cabinLength"], cabin_width: air["cabinWidth"], category_id: category&.id, flight_number_token: air["flightNumberToken"], subcharter: air["subcharter"], cargo: air["cargo"], ambulance: air["ambulance"], 
              type_rating: air["typeRating"], type_of_use: air["typeOfUse"], number_of_seats: air["numberOfSeats"],
              cabin_crew: air["layout"]["cabinCrew"], flight_crew: air["layout"]["flightCrew"], onboard_engineer: air["layout"]["onboardEngineer"])

            if air["equipment"].present?
              air_eq = aircraft.create_aircraft_equipment(v110: air["equipment"]["v110"], v230: air["equipment"]["v230"], headsets: air["equipment"]["headsets"], tv: air["equipment"]["tv"], cd_dvd: air["equipment"]["cd_dvd"], wifi: air["equipment"]["wifi"], sat_phone: air["equipment"]["satPhone"], sat_tv: air["equipment"]["satTv"], entertainment_system: air["equipment"]["entertainmentSystem"], lavatory: air["equipment"]["lavatory"], enclosed_lavatory: air["equipment"]["enclosedLavatory"], coffee_pot: air["equipment"]["coffeePot"], espresso: air["equipment"]["espresso"], ice_bin: air["equipment"]["iceBin"], microwave_oven: air["equipment"]["microwaveOven"], warming_oven: air["equipment"]["warmingOven"], smoking_allowed: air["equipment"]["smokingAllowed"], pets_allowed: air["equipment"]["petsAllowed"], baggage_volume: air["equipment"]["baggageVolume"], ski_tube: air["equipment"]["skiTube"], golf_bags: air["equipment"]["golfBags"], standard_suitcases: air["equipment"]["standardSuitcases"], max_weight: air["equipment"]["maxWeight"])
            end
            aircraft_data = aircraft.present? ? aircraft.id : air["tailNumber"]
            aircrafts << aircraft_data
            
            if air["links"].present?
              air["links"].each do |link|
                air_links = aircraft.aircraft_links.create(rel: link["rel"], link_url: link["href"])
                if air_links.rel == "picture"
                  url = URI(air_links.link_url)
                  url = URI("#{ENV['FLEX_URL']}"+url.request_uri)
                  https = Net::HTTP.new(url.host, url.port)
                  https.use_ssl = true
                  request = Net::HTTP::Get.new(url)
                  request["x-auth-token"] = ENV["FLEX_AUTH_TOKEN"]
                  form_data = []
                  request.set_form form_data, 'multipart/form-data'
                  response = https.request(request)
                  response.body
                  file = File.open('public/image.jpg', 'wb') do |f|
                    f.write(response.body)
                  end
                  downloaded_image = open("public/image.jpg")
                  air_links.picture.attach(io: downloaded_image, filename: "air_image")
                end
                if air_links.rel == "schedule"
                  url = URI(air_links.link_url)
                  url = URI("#{ENV['FLEX_URL']}"+url.request_uri)
                  res = api_call(url)
                  if res.present?
                    res.each do |sch|
                      schedule = aircraft.aircraft_schedules.find_or_create_by(schedule_id: sch["id"])
                      schedule.update(departure_airport: sch["departureAirport"], arrival_airport: sch["arrivalAirport"], arrival_date: sch["arrivalDate"], arrival_date_utc: sch["arrivalDateUTC"], departure_date: sch["departureDate"], departure_date_utc: sch["departureDateUTC"], pax: sch["pax"], trip_number: sch["tripNumber"], workflow: sch["workflow"], fpl_type: sch["fplType"], workflow_custom_name: sch["workflowCustomName"])
                    end
                  end
                end
              end
            end
            if air["keyAccountManager"].present?
              
              air_account_manager = aircraft.create_aircraft_account_manager(
                                                  external_reference: air["keyAccountManager"]["externalReference"],
                                                  first_name: air["keyAccountManager"]["firstName"],
                                                  last_name: air["keyAccountManager"]["lastName"],
                                                  log_name: air["keyAccountManager"]["logName"],
                                                  gender: air["keyAccountManager"]["gender"],
                                                  status: air["keyAccountManager"]["status"],
                                                  salutation: air["keyAccountManager"]["salutation"],
                                                  internal_id: air["keyAccountManager"]["internalId"])
            end
          end
        end
        aircrafts
      end
    end
  end
end
