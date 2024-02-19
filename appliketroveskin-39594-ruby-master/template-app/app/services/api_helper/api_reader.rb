module ApiHelper
    class ApiReader
        require "uri"
        require "net/http"
        def call(url, request_params, body, api_type)

            url = URI(url)

            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true
            if api_type == "post"
                request = Net::HTTP::Post.new(url)
            elsif api_type == "put"
                request = Net::HTTP::Put.new(url)
            elsif api_type == "delete"
                request = Net::HTTP::Delete.new(url)
            else
                request = Net::HTTP::Get.new(url)
            end
            if request_params.present?
                request_params.each do |key, value|
                    request[key] = value
                end
            end
            if body.present?
                request.body = body.to_json
                request.body = body if request_params["Content-Type"] == "application/x-www-form-urlencoded"
            end
            response = https.request(request)
        end

    end
end
