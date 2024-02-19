module BxBlockShopifyintegration
    class ShopifyDiscountsController < ApplicationController
        
        def initialize(params)
            @params = params
        end

        def get_discount(user, products, discount_code)
            endpoint = "/admin/api/2021-04/discount_codes/lookup.json?code=#{discount_code}"
            discount = get_response(endpoint)
            return 0 if discount["discount_code"].nil? && discount["location"].nil?

            discount = discount["location"][0] if discount["location"].present?
            ar = discount.to_s.split("/")
            price_rule_id = ar[ar.index("price_rules") + 1].to_i
            endpoint = "/admin/api/2021-04/price_rules/#{price_rule_id}.json"
            price_rule = JSON.parse(get_response(endpoint))["price_rule"]

            if price_rule["once_per_customer"]
                return -1 if user.discount_code_usages.pluck(:discount_code).include? price_rule["title"]
            end

            return -2 if !price_rule["ends_at"].nil? && price_rule["ends_at"].to_time <= Time.now
            return -3 unless user.membership_plan[:plan_type][0].downcase == discount_code[0].downcase

            discount_codes = []
            if price_rule["target_selection"] == "all"
                discount_codes << {
                    "code": price_rule["title"],
                    "type": price_rule["value_type"],
                    "amount": (price_rule["value"].to_f).abs.to_s
                }
            else 
                amount = 0
                product_ids = price_rule["entitled_product_ids"].map(&:to_s)
                products.each do |product|
                    if product_ids.include? product["product_id"].to_s
                        amount = amount + (price_rule["value"].to_f).abs if price_rule["value_type"] == "fixed_amount"
                        amount = amount + (price_rule["value"].to_f).abs/100*(product["price"].to_f * product["quantity"].to_i) if price_rule["value_type"] == "percentage"
                        
                    end
                end
                discount_codes << {
                    "code": price_rule["title"],
                    "type": "fixed_amount",
                    "amount": amount
                }
            end
            return 0 if discount_codes.first[:amount].to_i == 0

            discount_codes
        end
    end

end