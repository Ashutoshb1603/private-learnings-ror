module BxBlockShopifyintegration
    class ShopifyProductsController < ApplicationController
        
        def initialize(params)
            @params = params
            @country = @params[:country] || "Ireland"
        end

        def products(collection_id="", search_params="", page_info="", limit=240)
            # page_limit = limit.present? && page_info.present? ? "?page_info=#{page_info}" : "?status=active"
            if collection_id.present?
                page_limit = limit.present? && (page_info.present? or !search_params.present?) ? "?limit=#{limit}&page_info=#{page_info}" : "?status=active&limit=250"

                endpoint = "/admin/api/2021-10/products.json#{page_limit}"
                endpoint = "/admin/api/2021-10/collections/#{collection_id}/products.json#{page_limit}" if collection_id.present?
                response = JSON.parse(get_response(endpoint, "", "get", "", true))
                products = response["products"] || []
                next_page_info = response["next"] || ""
                while next_page_info.present?
                    endpoint = "/admin/api/2021-10/products.json?page_info=#{next_page_info}&limit=250"
                    response = JSON.parse(get_response(endpoint, "", "get", "", true))
                    products += response["products"]
                    next_page_info = response['next'] || ''
                end
                prev_page_info = response["prev"] || ""
            end
            products = redis_products if products.nil?
            products = products.reject {|prod| prod['status'] == 'draft' || prod['status'] == 'archived'}
            filtered_products = search_params.present? ? {products: [], prev_page_info: prev_page_info, next_page_info: next_page_info} : {products: products, prev_page_info: prev_page_info, next_page_info: next_page_info}
            if search_params.present?
                top_results = {products: [], prev_page_info: prev_page_info, next_page_info: next_page_info}
                if search_params.present?
                    search_params = search_params.downcase
                    products.each do |product|
                        if (product["variants"].find{|prod| prod["inventory_management"] != nil}.present? && product["variants"].find{|prod| prod["inventory_quantity"] != 0}.present? ) || (product["variants"].find{|prod| prod["inventory_management"] == nil}.present?)
                            if product["title"].downcase.include? search_params
                                top_results[:products] << product
                            else
                                filtered_products[:products] << product if product["vendor"].downcase.include? search_params or
                                                            product["body_html"].downcase.include? search_params or
                                                            product["product_type"].downcase.include? search_params or
                                                            product["tags"].downcase.include? search_params
                            end
                        end
                    end
                end
            filtered_products[:products] = top_results[:products] + filtered_products[:products]
            end
            ids = filtered_products[:products].map {|product| product["id"]}.join(",")
            endpoint = "/admin/api/2021-10/products.json?ids=#{ids}"
            filtered_products = {products: JSON.parse(get_response(endpoint, "", "get", "", true))["products"]} if collection_id.present?
            filtered_products[:products].map {|product| 
                # product[:variants] = response["products"].select {|p| p["id"].to_s == product["id"].to_s}[0]["variants"] if collection_id.present?
                product[:currency] = @country.downcase == "ireland" ? "EUR" : "GBP"
            }
            filtered_products
        end

        def product_show(id, location="")
            product_id = id
            endpoint = "/admin/api/2021-04/products/#{product_id}.json"
            product = JSON.parse(get_response(endpoint, "", "get", "", false, location)).merge({currency: @country.downcase == "ireland" ? "EUR" : "GBP"})
        end

        def product_with_title(title)
            endpoint = "/admin/api/2021-04/products.json?title=#{title}"
            response = JSON.parse(get_response(endpoint))
        end

        def get_products(product_ids)
            endpoint = "/admin/api/2021-04/products.json?status=active&ids=#{product_ids.join(",")}"
            response = JSON.parse(get_response(endpoint))['products']
            products = response.reject { |prod| prod['status'] == 'draft' || prod['status'] == 'archived' }
        end

        def product_count()
            endpoint = "/admin/api/2021-10/products/count.json?status=active"
            response = JSON.parse(get_response(endpoint))
        end

        def product_recommendation(user, search_params="", allow_custom_tags=false)
            products = redis_products
            products = products.reject {|prod| prod['status'] == 'draft' || prod['status'] == 'archived'}
            products.map {|product| product[:currency] = @country.downcase == "ireland" ? "EUR" : "GBP"}
            recommended_products = []
            
            if allow_custom_tags
                hero_product = BxBlockCatalogue::HeroProduct.first
                customized_tags = hero_product.tags.split(/[\n\r, ]+/) if hero_product&.tags_type == 'customized' and hero_product&.tags.present?
            end
            user_tags = []
            user_tags = (customized_tags || user.tags.pluck(:title)) unless user.type == "AdminAccount"
            search_params = search_params&.downcase
            top_results = []
            products.each do |product|
                if !allow_custom_tags
                    if (product["variants"].find{|prod| prod["inventory_management"] != nil}.present? && product["variants"].find{|prod| prod["inventory_quantity"] != 0}.present? ) || (product["variants"].find{|prod| prod["inventory_management"] == nil}.present?)
                        tags = product["tags"].split(", ")
                        if product['title'].downcase.include? search_params
                            top_results << product
                        else
                        recommended_products << product if (product if product["vendor"].downcase.include? search_params or
                                                                       product["body_html"].downcase.include? search_params or
                                                                       product["product_type"].downcase.include? search_params or
                                                                       product["tags"].downcase.include? search_params)
                        end
                    end
                else
                    if (product["variants"].find{|prod| prod["inventory_management"] != nil}.present? && product["variants"].find{|prod| prod["inventory_quantity"] != 0}.present? ) || (product["variants"].find{|prod| prod["inventory_management"] == nil}.present?)
                        tags = "hero product"
                        recommended_products << product if (product if product["tags"].downcase.include? tags)
                    end
                end
            end
            recommended_products = top_results + recommended_products
            recommended_products.empty? ? products[0..3] : recommended_products
        end

        def redis_products
            uri = URI.parse(ENV['REDIS_URL'])
            redis = Redis.new(host: uri.host)
            key = "MmNhYjUzYTA3Y2EwOWQxYjk5OWViMDlk"
            crypt = ActiveSupport::MessageEncryptor.new(key)
            if @country.downcase == "ireland"
                ireland_key= redis.get("ireland_products")
                products = crypt.decrypt_and_verify(ireland_key)
            else
                uk_key= redis.get("uk_products")
                products = crypt.decrypt_and_verify(uk_key)
            end
            return products
        end

        def favourites(product_ids)
            endpoint = "/admin/api/2021-04/products.json?status=active&ids=#{product_ids.join(",")}"
            products = JSON.parse(get_response(endpoint))["products"]
            products = products.reject{ |prod| prod['status'] == 'archived' || prod['status'] == 'draft' }
            products.map {|product| product[:currency] = @country.downcase == "ireland" ? "EUR" : "GBP"}
            products
        end

        def product_library
            endpoint = "/admin/api/2021-04/collection_listings.json"
            library = JSON.parse(get_response(endpoint))["collection_listings"]
        end

        def product_library_show(id)
            collection_id = id
            endpoint = "/admin/api/2021-04/collections/#{collection_id}.json"
            collection = JSON.parse(get_response(endpoint))
        end

    end
end
