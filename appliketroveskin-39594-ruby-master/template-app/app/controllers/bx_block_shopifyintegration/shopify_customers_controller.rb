module BxBlockShopifyintegration
    class ShopifyCustomersController < ApplicationController
           
        def initialize(params)
            @params = params
        end

        def index
            endpoint = "/admin/api/2021-04/customers.json"
            customers = JSON.parse(get_response(endpoint))
        end

    end
end
