module BxBlockCatalogue
    class ShopifyProductsWorker
        include Sidekiq::Worker

        def perform()
            puts "in the worker"
            endpoint = "/admin/api/2021-10/products.json?status=active&limit=250"
            response = get_products(endpoint, "Ireland")
            next_page_info = response["next"] || ""
            ireland_products = response['products']
            while next_page_info.present?
                endpoint = "/admin/api/2021-10/products.json?page_info=#{next_page_info}&limit=250"
                response2 = get_products(endpoint, "Ireland")
                ireland_products += response2["products"]
                next_page_info = response2['next'] || ''
            end
            endpoint = "/admin/api/2021-10/products.json?status=active&limit=250"
            response = get_products(endpoint, "Uk")
            next_page_info = response["next"] || ""
            uk_products = response['products']
            while next_page_info.present?
                endpoint = "/admin/api/2021-10/products.json?page_info=#{next_page_info}&limit=250"
                response2 = get_products(endpoint, "Uk")
                uk_products += response2["products"]
                next_page_info = response2['next'] || ''
            end
            key = "MmNhYjUzYTA3Y2EwOWQxYjk5OWViMDlk"
            crypt = ActiveSupport::MessageEncryptor.new(key)
            ireland_data = crypt.encrypt_and_sign(ireland_products)
            ireland_key = BxBlockCatalogue::ProductKey.find_or_create_by(location: "Ireland")
            ireland_key.update(last_refreshed: DateTime.now)
            uri = URI.parse(ENV['REDIS_URL'])
            redis = Redis.new(host: uri.host)
            redis.set("ireland_products", ireland_data)
            uk_data = crypt.encrypt_and_sign(uk_products)
            uk_key = BxBlockCatalogue::ProductKey.find_or_create_by(location: "Uk")
            uk_key.update(last_refreshed: DateTime.now)
            redis.set("uk_products", uk_data)

        end

        def get_products(endpoint, location)
            url = "https://#{ENV['SHOPIFY_HOSTNAME']}.myshopify.com" + endpoint
            url = "https://#{ENV['SHOPIFY_HOSTNAME_UK']}.myshopify.com" + endpoint if location.downcase == "uk"
            request_params = Hash.new
            request_params["Content-Type"] = "application/json"
            request_params["X-Shopify-Access-Token"] = ENV['SHOPIFY_ACCESS_TOKEN']
            request_params["X-Shopify-Access-Token"] = ENV['SHOPIFY_ACCESS_TOKEN_UK'] if location.downcase == "uk"
            url = URI(url)
            https = Net::HTTP.new(url.host, url.port)
            https.use_ssl = true
            request = Net::HTTP::Get.new(url)
            if request_params.present?
              request_params.each do |key, value|
                request[key] = value
              end
            end
            response = https.request(request)
            link = response["link"]
            response_json = JSON.parse(response.read_body)
            response_json["prev"] = link.present? && link.include?("prev") ? link.split("page_info").second.split(">\;").first[1..-1] : ""
            response_json["next"] = link.present? && link.include?("next") ? link.split("page_info").last.split(">\;").first[1..-1] : ""
            # JSON.generate(response_json)
            response_json
        end
    end
end
