ActiveAdmin.register_page "Business Aircraft on Major Airports" do
  menu parent: 'RadarBox Statistics', label: 'Business Aircraft on Major Airports'

  content title: "Aircraft" do
  	require "uri"
  	require "net/http"

  	url = URI("https://api.radarbox.com/v2/statistics/airports/business")

  	https = Net::HTTP.new(url.host, url.port)
  	https.use_ssl = true

  	request = Net::HTTP::Get.new(url)
  	request["Authorization"] = "Bearer 93af31a9c785d864e65bb1e0340d96a214dc2485"
  	response = https.request(request)
  	@res = response.read_body
    @res = JSON.parse(@res)

    if @res["success"] == false
      column do
        panel "Flight Data" do
          @res["comment"]
        end
      end
    elsif @res["statistics"].present?
      columns do
        column do
          panel "Flight Statistics" do
            table do
              tbody do
                tr do
                  th do
                    "Day"
                  end
                  th do
                    "ICAO Code"
                  end
                  th do
                    "Total Flights"
                  end
                end
                @air_statistics = Kaminari.paginate_array(@res["statistics"]).page(params[:page] || 1).per(1)
                @air_statistics.each do |st|
                  st["airportStatistics"].each do |stat|
                    tr do
                      td do
                        st["day"]
                      end
                      td do
                        stat["icaoCode"]
                      end
                      td do
                        stat["totalFlights"]
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      div class: "paginate" do
        paginate @air_statistics
      end
    else
      column do
        panel "Flights statistics" do
          @res["comment"]
        end
      end
    end
  end
end