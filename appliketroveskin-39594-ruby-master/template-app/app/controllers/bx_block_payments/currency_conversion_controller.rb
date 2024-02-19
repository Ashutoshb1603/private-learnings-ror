module BxBlockPayments
    class CurrencyConversionController < ApplicationController
        
        def convert(from, to, amount)
            response = JSON.parse(get_response(from, to, amount))
            if response["status"] == "success"
                {status: 200, amount: response["rates"][to.upcase]["rate_for_amount"].to_d}
            else
                {status: 422, message: response}
            end
        end
    end
end