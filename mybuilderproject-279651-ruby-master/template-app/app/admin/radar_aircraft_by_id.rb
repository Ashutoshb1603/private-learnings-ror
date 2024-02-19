ActiveAdmin.register_page "Radar Aircraft by Id" do
  menu false

  content title: "Aircraft" do
  	require "uri"
  	require "net/http"

  	url = URI("https://api.radarbox.com/v2/aircraft?registration=#{params[:tail_number]}")

  	https = Net::HTTP.new(url.host, url.port)
  	https.use_ssl = true

  	request = Net::HTTP::Get.new(url)
  	request["Authorization"] = "Bearer 93af31a9c785d864e65bb1e0340d96a214dc2485"
  	request["Cookie"] = "JSESSIONID=FCB46463E350B2939D51742DBFA85C82"

  	response = https.request(request)
  	@title = response.read_body
    @title = JSON.parse(@title)

    if @title["success"] == false
      columns do
        column do
          panel "Aircraft Data" do
            @title["comment"]
          end
        end
      end
    elsif @title["aircraft"].present?
      columns do
        column do
          panel "Aircraft Details" do
            table do
              tbody do
                tr do
                  th do
                    "Type Description"
                  end
                  th do
                    "Type Icao"
                  end
                  th do
                    "Class Description"
                  end
                  th do
                    "Registration"
                  end
                  th do
                    "Company Name"
                  end
                  th do
                    "Serial Number"
                  end
                end
                tr do
                  td do
                    @title["aircraft"]["typeDescription"]
                  end
                  td do
                    @title["aircraft"]["typeIcao"]
                  end
                  td do
                    @title["aircraft"]["classDescription"]
                  end
                  td do
                    @title["aircraft"]["registration"]
                  end
                  td do
                    @title["aircraft"]["companyName"]
                  end
                  td do
                    @title["aircraft"]["serialNumber"]
                  end
                end
              end
            end
            panel "Aircraft Statitics" do
            	table do
            	  tbody do
            	    tr do
            	      th do
            	        "Year"
            	      end
            	      th do
            	        "Month"
            	      end
            	      th do
            	        "distance"
            	      end
            	      th do
            	        "Duration"
            	      end
            	      th do
            	        "Active Days"
            	      end
            	      th do
            	        "Flights"
            	      end
            	    end
            	    @statitics = @title["aircraft"]["aircraftStatitics"]
            	    @statitics.each do |st|
	            	    tr do
	            	      td do
	            	        st["year"]
	            	      end
	            	      td do
	            	        st["month"]
	            	      end
	            	      td do
	            	        st["distance"]
	            	      end
	            	      td do
	            	        st["duration"]
	            	      end
	            	      td do
	            	        st["activeDays"]
	            	      end
	            	      td do
	            	        st["flights"]
	            	      end
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