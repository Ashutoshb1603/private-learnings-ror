module BxBlockShopifyintegration
    class ShopifyOrdersController < ApplicationController
                
        def initialize(params)
            @params = params
        end

        def create_orders(user, order_params)
            endpoint = "/admin/api/2021-04/orders.json"
            shipping_address = {}
            address = BxBlockAddress::Address.find(order_params[:address_id])
            customer = address.addressable
            first_name = customer.first_name.to_s
            last_name = customer.last_name.to_s
            customer_information = {
                "first_name": first_name,
                "last_name": last_name,
                "email": customer.email
            }

            phone =  "+#{customer.full_phone_number}" if customer.type != "AdminAccount" && customer.full_phone_number&.present?

            billing_address = {
                "first_name": first_name,
                "last_name": last_name,
                "address1": address.street + " " + address.county,
                "phone": order_params[:phone],
                "city": address.city,
                "province": address.province,
                "country": address.country,
                "zip": address.postcode
            }
            shipping_address = billing_address if order_params[:shipping_id].nil? or order_params[:shipping_id] == order_params[:address_id]

            if order_params[:shipping_id].present? and order_params[:shipping_id] != order_params[:address_id]
                address = BxBlockAddress::Address.find(order_params[:shipping_id])
                customer = address.addressable
                shipping_address = {
                    "first_name": customer.first_name.to_s,
                    "last_name": customer.last_name.to_s,
                    "address1": address.street + " " + address.county,
                    "phone": order_params[:phone],
                    "city": address.city,
                    "province": address.province,
                    "country": address.country,
                    "zip": address.postcode
                }
            end
            
            line_items = []
            cart_total = 0
            cart_items =  BxBlockShoppingCart::CartItem.where(id: order_params[:cart_item_ids])
            cart_items.each do |cart_item|
                item = {
                    "product_id": cart_item.product_id,
                    "variant_id": cart_item.variant_id,
                    "price": cart_item.price,
                    "quantity": cart_item.quantity
                }
                cart_total +=(cart_item.price*cart_item.quantity)
                line_items << item
            end
            requires_shipping = true
            requires_shipping = order_params[:requires_shipping] unless order_params[:requires_shipping].nil?
            shipping_and_tax_lines = ShopifyTaxAndShippingController.new(@params).calculate_charges(cart_total, address.country, requires_shipping)
            discount_codes = ShopifyDiscountsController.new(@params).get_discount(user, line_items, order_params[:discount_codes].first["code"]) if order_params[:discount_codes].present?
            images = cart_items.pluck(:product_id, :product_image_url)
            tags = ENV["TEST_ENV"] == "true" ? "TEST ORDER" : "APP ORDER"
            test_env = ENV["TEST_ENV"] == "true" ? true : false
            discount = 0
            discount = discount_codes&.first[:amount].to_d if !discount_codes.kind_of?(Integer) && discount_codes&.first.present?
            total_amount = cart_total + shipping_and_tax_lines[:shipping_lines]&.first[:price].to_d - discount
            transaction_object = [{"kind": "capture",
                "status": "success",
                "currency": (@params[:country].downcase == "ireland" ? "EUR" : "GBP"),
                "gateway": "manual",
                "amount": total_amount}]
            body = {order: order_params.merge(tags: tags, test: test_env, line_items: line_items, shipping_address: shipping_address, billing_address: billing_address, customer: customer_information, shipping_lines: shipping_and_tax_lines[:shipping_lines], tax_lines: shipping_and_tax_lines[:tax_lines], taxes_included: "true", requires_shipping: requires_shipping, transactions: transaction_object, send_receipt: false, send_fulfillment_receipt: false).except("discount_codes", "cart_items_ids")}
            body = {order: order_params.merge(tags: tags, test: test_env, line_items: line_items, shipping_address: shipping_address, billing_address: billing_address, customer: customer_information, discount_codes: discount_codes, shipping_lines: shipping_and_tax_lines[:shipping_lines], tax_lines: shipping_and_tax_lines[:tax_lines], taxes_included: "true", requires_shipping: requires_shipping, transactions: transaction_object, send_receipt: false, send_fulfillment_receipt: false)} if (!discount_codes.nil? && discount_codes.kind_of?(Array))
            body[:order][:phone] = phone if body[:order][:phone].blank? && phone.present?
            order = JSON.parse(get_response(endpoint, body, "post", "json"))
            cart_items.delete_all
            order.merge(images: images)
        end

        def cancel_order(user, order_id, order_params)
            endpoint = "/admin/api/2021-04/orders/#{order_id}/cancel.json"
            test_env = ENV["TEST_ENV"] == "true" ? true : false
            order = JSON.parse(get_response(endpoint, "", "post", "json"))
        end


        def order_view(id, location)
            endpoint = "/admin/api/2021-04/orders/#{id}.json"
            order = JSON.parse(get_response(endpoint, "", "get", "", false, location))
        end

        def order_list(ids, location)
            endpoint = "/admin/api/2021-04/orders.json?ids=#{ids.join(",")}"
            order = JSON.parse(get_response(endpoint, "", "get", "", false, location))
        end

        def locations
            endpoint = "/admin/api/2021-04/locations.json"
            location = JSON.parse(get_response(endpoint))
        end

    end
end
