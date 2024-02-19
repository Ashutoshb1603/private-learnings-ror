module BxBlockCatalogue
    class ProductsController < ApplicationController
        require "uri"
        require "net/http"
        include BxBlockShopifyintegration
        before_action :current_user, except: [:refresh_products, :get_products]
        before_action :shopify_products, except: [:refresh_products, :get_products]
        def index
            if params[:collection_id].present?
                @collection_view = @current_user.product_collection_views.where('created_at > ? AND collection_id = ?', Time.now - 1.day, params[:collection_id]).first
                @current_user.product_collection_views.create(collection_id: params[:collection_id]) if @collection_view.nil?
            end
            products = @@shopify.products(params[:collection_id], params[:search_params], params[:page]) if params[:collection_id].present?
            if !(params[:collection_id].present?)
                location = @current_user.location || "Ireland"
                uri = URI.parse(ENV['REDIS_URL'])
                redis = Redis.new(host: uri.host)
                key = "MmNhYjUzYTA3Y2EwOWQxYjk5OWViMDlk"
                crypt = ActiveSupport::MessageEncryptor.new(key)
                begin
                    if location.downcase == "ireland"
                        ireland_key= redis.get("ireland_products")
                        products = crypt.decrypt_and_verify(ireland_key)
                        products = sort_products(products, params[:search_params]) if params[:search_params].present?
                    else
                        uk_key= redis.get("uk_products")
                        products = crypt.decrypt_and_verify(uk_key)
                        products = sort_products(products, params[:search_params]) if params[:search_params].present?
                    end
                rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
                    products = []
                    return render json: {error: "please refresh list"}, status: :unprocessable_entity
                end
                products[:products].map {|product|
                    product['currency'] = location.downcase == "ireland" ? "EUR" : "GBP"
                }
            end
            products[:products].map do |product|
                product_id = product["id"].to_s
                product[:is_favourite] = @current_user.customer_favourite_products.where(product_id: product_id).present?
                product[:in_cart] = false
                product[:in_cart] = @current_user.cart_items.pluck(:product_id).include? product["id"].to_s if @current_user.type != "AdminAccount"
            end
            products[:products] = products[:products].reject {|prod| prod['status'] == 'archived' || prod['status'] == 'draft'}
            render json: products
        end
        def show
            product_id = params[:id]
            is_favourite = @current_user.customer_favourite_products.where(product_id: product_id).present?
            in_cart = false
            in_cart = @current_user.cart_items.pluck(:product_id).include? product_id if @current_user.type != "AdminAccount"
            video = ProductVideo.find_by_product_id(product_id)&.video_url || ""
            product = @@shopify.product_show(product_id)
            product = product.merge(is_favourite: is_favourite, in_cart: in_cart, video: video)
            render json: product
        end

        def recommendation
            if params[:search].present?
                products = @@shopify.product_recommendation(@current_user, params[:search])
            else
                products = @@shopify.product_recommendation(@current_user)
            end
            # if @current_user.type != "AdminAccount"
                products.map do |product|
                    product[:is_favourite] = @current_user.customer_favourite_products.where(product_id: product["id"].to_s).present?
                    product[:in_cart] = false
                    product[:in_cart] = @current_user.cart_items.pluck(:product_id).include? product["id"].to_s if @current_user.type != "AdminAccount"
                end
            # end
            title = "HERO PRODUCTS"
            render json: {products: products.shuffle, title: title}
        end

        def recommend_product
            if params[:product_id].present?
                if @current_user&.role&.name != "User"
                    prod = @@shopify.product_show(params[:product_id], "Ireland")
                    prod = @@shopify.product_show(params[:product_id], "UK") if prod['errors'].present?
                    title = prod['product']['title']
                    price = prod['product']['variants'][0]['price']
                    recommended_product = @current_user.recommended_products.create(account_id: params[:account_id], product_id: params[:product_id], title: title, price: price)
                    render json: {recommended_product: recommended_product}
                end
            else
                render json: { errors: { message: "parameter missing" } }, status: :unprocessable_entity
            end
        end

        def sort_products(products, search)
            search = search.downcase
            filtered_products = []
            top_results = []
            products = products.reject { |prod| prod['status'] == 'archived' || prod['status'] == 'draft' }
            products.each do |product|
                if (product["variants"].find{|prod| prod["inventory_management"] != nil}.present? && product["variants"].find{|prod| prod["inventory_quantity"] != 0}.present? ) || (product["variants"].find{|prod| prod["inventory_management"] == nil}.present?)
                    if product["title"].downcase.include? search
                        top_results << product
                    else
                        filtered_products << product if product["vendor"].downcase.include? search or
                                                    product["body_html"].downcase.include? search or
                                                    product["product_type"].downcase.include? search or
                                                    product["tags"].downcase.include? search
                    end
                end
            end
            top_results = top_results.sort_by{|prod| prod['title'].downcase.index(search)}
            filtered_products = top_results + filtered_products
            filtered_products = {products: filtered_products, prev_page: "", next_page: ""}
           return filtered_products
        end

        def hero_products
            products = @@shopify.product_recommendation(@current_user, "", true)
            # if @current_user.type != "AdminAccount"
                products.map do |product|
                    product[:is_favourite] = @current_user.customer_favourite_products.where(product_id: product["id"].to_s).present?
                    product[:in_cart] = false
                    product[:in_cart] = @current_user.cart_items.pluck(:product_id).include? product["id"].to_s if @current_user.type != "AdminAccount"
                end
            # end
            title = BxBlockCatalogue::HeroProduct.first&.title || "HERO PRODUCTS"
            render json: {products: products, title: title}
        end

        def set_as_favourite
            favourite = @current_user.customer_favourite_products.find_or_create_by(product_id: params[:product_id])
            render json: {message: "Product added as favourite", data: favourite}
        end

        def remove_favourite
            @current_user.customer_favourite_products.find_by_product_id(params[:product_id]).delete
            render json: {message: "Product removed from favourites"}
        end

        def favourites
            product_ids = @current_user.customer_favourite_products.pluck(:product_id)
            products = product_ids.present? ? @@shopify.favourites(product_ids) : []
            render json: {products: products}
        end

        def product_library
            library = @@shopify.product_library
            render json: library
        end

        def refresh_products
            key = "MmNhYjUzYTA3Y2EwOWQxYjk5OWViMDlk"
            if params[:data].downcase == "ireland"
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
                ireland_products = ireland_products.reject {|prod| prod['status'] == 'draft' || prod['status'] == 'archived'}
                crypt = ActiveSupport::MessageEncryptor.new(key)
                ireland_data = crypt.encrypt_and_sign(ireland_products)
                ireland_key = BxBlockCatalogue::ProductKey.find_or_create_by(location: "Ireland")
                ireland_key.update(last_refreshed: DateTime.now)
                uri = URI.parse(ENV['REDIS_URL'])
                redis = Redis.new(host: uri.host)
                redis.set("ireland_products", ireland_data)
                respond_to do |format|
                    format.html
                    format.json { render json: {data: "completed"}, status: 200 }
                end
                # render json: {data: "updated successfully"}, status: 200
            else
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
                uk_products = uk_products.reject {|prod| prod['status'] == 'draft' || prod['status'] == 'archived'}
                crypt = ActiveSupport::MessageEncryptor.new(key)
                uk_data = crypt.encrypt_and_sign(uk_products)
                uk_key = BxBlockCatalogue::ProductKey.find_or_create_by(location: "Uk")
                uk_key.update(last_refreshed: DateTime.now)
                uri = URI.parse(ENV['REDIS_URL'])
                redis = Redis.new(host: uri.host)
                redis.set("uk_products", uk_data)
                data = { response: "succeeded" }
                respond_to do |format|
                    format.html
                    format.json { render json: data }
                end
            end
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
