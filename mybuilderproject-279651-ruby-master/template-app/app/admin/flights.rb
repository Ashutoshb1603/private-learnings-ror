ActiveAdmin.register_page "Flights" do
  menu false

  content title: "Flights" do
    require "uri"
    require "json"
    require "net/http"

    url = URI("https://api.radarbox.com/v2/flights/live")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer 93af31a9c785d864e65bb1e0340d96a214dc2485"
    request["Content-Type"] = "application/json"
    if params[:tail_number].present?
      request.body = JSON.dump({
        "pageSize": 10,
        "page": 1,
        "registrations": [
          params[:tail_number]
        ]
      })
    else
      request.body = JSON.dump({
        "pageSize": 10,
        "page": 1,
        "aircraftTypes": [
          params[:aircraft_type]
        ]
      })
    end

    response = https.request(request)
    @title = response.read_body
    @title = JSON.parse(@title)
    if @title["success"] == false
      columns do
        column do
          panel "Flights Update" do
            @title["comment"]
          end
        end
      end
    elsif @title["flights"].present?
      columns do
        column do
          panel "Flights Live Location" do
            table do
              tbody do
                tr do
                  th do
                    "Aircraft Type Description"
                  end
                  th do
                    "Airline Icao"
                  end
                  th do
                    "Airline Name"
                  end
                  th do
                    "Aircraft Registration"
                  end
                  th do
                    "Aircraft Type"
                  end
                  th do
                    "Flight Number Icao"
                  end
                  th do
                    "Altitude"
                  end
                  th do
                    "Longitude"
                  end
                  th do
                    "Latitude"
                  end
                  th do
                    "Ground Speed"
                  end
                  th do
                    "Heading"
                  end
                  th do
                    "Source"
                  end
                  th do
                    "Status"
                  end
                  th do
                    "Aircraft ModeS"
                  end
                  th do
                    "Aircraft Classes"
                  end
                end
                @title["flights"].each do |flight_data|
                  tr do
                    td do
                      flight_data["aircraftTypeDescription"]
                    end
                    td do
                      flight_data["airlineIcao"]
                    end
                    td do
                      flight_data["airlineName"]
                    end
                    td do
                      flight_data["aircraftRegistration"]
                    end
                    td do
                      flight_data["aircraftType"]
                    end
                    td do
                      flight_data["flightNumberIcao"]
                    end
                    td do
                      flight_data["altitude"]
                    end
                    td do
                      flight_data["longitude"]
                    end
                    td do
                      flight_data["latitude"]
                    end
                    td do
                      flight_data["groundSpeed"]
                    end
                    td do
                      flight_data["heading"]
                    end
                    td do
                      flight_data["source"]
                    end
                    td do
                      flight_data["status"]
                    end
                    td do
                      flight_data["aircraftModeS"]
                    end
                    td do
                      flight_data["aircraftClasses"]
                    end
                  end
                end
              end
            end
          end
        end
      end
    else
      columns do
        column do
          panel "Flights Update" do
            @title["comment"]
          end
        end
      end
    end
  end
end