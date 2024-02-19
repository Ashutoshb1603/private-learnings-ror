ActiveAdmin.register_page "Business Jet Models" do
  menu parent: 'RadarBox Statistics', label: 'Business Jet Models'

  content title: "Aircraft" do
  	require "uri"
  	require "net/http"

  	url = URI("https://api.radarbox.com/v2/statistics/flights/business/models")

  	https = Net::HTTP.new(url.host, url.port)
  	https.use_ssl = true

  	request = Net::HTTP::Get.new(url)
  	request["Authorization"] = "Bearer 93af31a9c785d864e65bb1e0340d96a214dc2485"
  	response = https.request(request)
  	@title = response.read_body
    @title = JSON.parse(@title)

    if @title["success"] == false
      column do
        panel "Aircraft Data" do
          @title["comment"]
        end
      end
    elsif @title["statistics"].present?
      columns do
        column do
          panel "Statistics" do
            table do
              tbody do
                tr do
                  th do
                    "Day"
                  end
                  th do
                    "Model"
                  end
                  th do
                    "Total Flights"
                  end
                end
                @statistics = Kaminari.paginate_array(@title["statistics"]).page(params[:page] || 1).per(5)
                @statistics.each do |st|
                  st["statistics"].each do |statistics|
                    tr do
                      td do
                        st["day"]
                      end
                      td do
                        statistics["model"]
                      end
                      td do
                        statistics["totalFlights"]
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      div id: "paginate" do
        paginate @statistics
      end
    else
      column do
        panel "Flights statistics" do
          @title["comment"]
        end
      end
    end
  end
end