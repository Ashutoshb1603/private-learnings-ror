module BxBlockShopifyintegration
    class ShopifyTaxAndShippingController < ApplicationController
                   
        def initialize(params)
            @params = params
        end

        def calculate_charges(cart_total, country="ireland", requires_shipping)
            country = "ireland" if country.nil?
            endpoint = "/admin/api/2021-04/shipping_zones.json"
            shipping_details = JSON.parse(get_response(endpoint, "", 'get', "", false, country))["shipping_zones"]
            shipping_charge = "0.00" 
            shipping_name = "Local Pickup"
            tax_charges = ""
            tax_name = ""
            if country.downcase == "uk"
                detail = shipping_details.find {|detail| ["domestic", "uk", "united kingdom"].include?(detail["name"].downcase)}
                if requires_shipping
                    detail["price_based_shipping_rates"].each do |object|
                        if object["min_order_subtotal"].to_d <= cart_total && (object["max_order_subtotal"].nil? || object["max_order_subtotal"].to_d >= cart_total)
                            shipping_name = object["name"]
                            shipping_charge = object["price"]
                        end
                    end
                end

                detail["countries"].each do |object|
                    if object["name"].downcase == country.downcase
                        tax_charges = object["tax"]
                        tax_name = object["tax_name"]
                    end
                end
            elsif Country.find_all_countries_by_continent('Europe').map{|x| x.name.downcase}.include?(country.downcase)
                detail = shipping_details.find {|detail| ["ireland", "eu (european union)"].include?(detail["name"].downcase)}
                if requires_shipping
                    detail["price_based_shipping_rates"].each do |object|
                        if object["min_order_subtotal"].to_d <= cart_total && (object["max_order_subtotal"].nil? || object["max_order_subtotal"].to_d >= cart_total)
                            shipping_name = object["name"]
                            shipping_charge = object["price"]
                        end
                    end
                end

                detail["countries"].each do |object|
                    if object["name"].downcase == country.downcase
                        tax_charges = object["tax"]
                        tax_name = object["tax_name"]
                    end
                end
            else
                detail = shipping_details.find {|detail| ["domestic", "rest of world", "worldwide"].include?(detail["name"].downcase)}
                if requires_shipping
                    detail["price_based_shipping_rates"].each do |object|
                        if object["min_order_subtotal"].to_d <= cart_total && (object["max_order_subtotal"].nil? || object["max_order_subtotal"].to_d >= cart_total)
                            shipping_name = object["name"]
                            shipping_charge = object["price"]
                        end
                    end
                end

                detail["countries"].each do |object|
                    if object["name"].downcase == country.downcase
                        tax_charges = object["tax"]
                        tax_name = object["tax_name"]
                    end
                end
            end
            shipping_details.each do |detail|
                if detail["name"].downcase == country.downcase
                    if requires_shipping
                        detail["price_based_shipping_rates"].each do |object|
                            if object["min_order_subtotal"].to_d <= cart_total && (object["max_order_subtotal"].nil? || object["max_order_subtotal"].to_d >= cart_total)
                                shipping_name = object["name"]
                                shipping_charge = object["price"]
                            end
                        end
                    end

                    detail["countries"].each do |object|
                        if object["name"].downcase == country.downcase
                            tax_charges = object["tax"]
                            tax_name = object["tax_name"]
                        end
                    end
                    break
                end
            end
            shipping_lines = [
                {
                  price: shipping_charge,
                  title: shipping_name
                }
              ]
            
            total_price = shipping_charge.to_d + cart_total.to_d
            tax_price = total_price - (total_price/(1+tax_charges.to_d))
            
            tax_lines = [
            {
                title: tax_name,
                rate: tax_charges,
                price: tax_price.round(2)
            }
            ]
            {shipping_lines: shipping_lines, tax_lines: tax_lines}
        end
    end
end
