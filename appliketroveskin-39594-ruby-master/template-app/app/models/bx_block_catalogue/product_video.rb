module BxBlockCatalogue
    class ProductVideo < ApplicationRecord
        require "uri"
        require "net/http"

        self.table_name = :product_videos

        validates :video_url, format: {with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'Please enter valid url'}
        validates :product_id, uniqueness: true, allow_blank: false

        before_save :convert_to_embedded_url

        def convert_to_embedded_url
            self.video_url.sub! "watch?v=", "embed/"
        end

        def self.product_name_eq(value)
            self.where(product_id: value)
        end

        def self.ransackable_scopes(_auth_object = nil)
            %i(product_name_eq)
        end
        
        def self.products
            @shopify = BxBlockShopifyintegration::ShopifyProductsController.new({country: 'ireland'})
            product_ids_with_video = BxBlockCatalogue::ProductVideo.all.pluck(:product_id)
            endpoint = "/admin/api/2021-10/products.json?status=active&limit=250"
            response = get_shopify_products(endpoint)
            next_page_info = response["next"] || ""
            @shopify_products = response['products']
            while next_page_info.present?
                endpoint = "/admin/api/2021-10/products.json?page_info=#{next_page_info}&limit=250"
                response2 = get_shopify_products(endpoint)
                @shopify_products += response2["products"]
                next_page_info = response2['next'] || ''
            end
            @shopify_products.select {|product| product_ids_with_video.include?product["id"].to_s}.pluck('title', 'id')
        end

        def self.get_shopify_products(endpoint)
            url = "https://#{ENV['SHOPIFY_HOSTNAME']}.myshopify.com" + endpoint
            request_params = Hash.new
            request_params["Content-Type"] = "application/json"
            request_params["X-Shopify-Access-Token"] = ENV['SHOPIFY_ACCESS_TOKEN']
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
