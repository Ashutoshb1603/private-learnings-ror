ActiveAdmin.register_page "Business Jet Operators" do
  menu parent: 'RadarBox Statistics', label: 'Business Jet Operators'

  content title: "Aircraft" do
  	require "uri"
  	require "net/http"

  	url = URI("https://api.radarbox.com/v2/statistics/flights/business/operators")

  	https = Net::HTTP.new(url.host, url.port)
  	https.use_ssl = true

  	request = Net::HTTP::Get.new(url)
  	request["Authorization"] = "Bearer 93af31a9c785d864e65bb1e0340d96a214dc2485"
  	response = https.request(request)
  	@jet_res = response.read_body
    @jet_res = JSON.parse(@jet_res)

    if @jet_res["success"] == false
      column do
        panel "Aircraft Details" do
          @jet_res["comment"]
        end
      end
    elsif @jet_res["statistics"].present?
      columns do
        column do
          panel "Aircraft Statistics" do
            table do
              tbody do
                tr do
                  th do
                    "Day"
                  end
                  th do
                    "Operator"
                  end
                  th do
                    "Total Flights"
                  end
                end
                @jet_statistics = Kaminari.paginate_array(@jet_res["statistics"]).page(params[:page] || 1).per(5)
                @jet_statistics.each do |st|
                  st["statistics"].each do |statistics|
                    tr do
                      td do
                        st["day"]
                      end
                      td do
                        statistics["operator"]
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
        paginate @jet_statistics
      end
    else
      column do
        panel "statistics" do
          @jet_res["comment"]
        end
      end
    end
  end
end