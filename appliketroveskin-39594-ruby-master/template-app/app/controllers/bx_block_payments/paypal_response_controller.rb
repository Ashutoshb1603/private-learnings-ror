module BxBlockPayments
    class PaypalResponseController < ApplicationController

        include ActionView::Layouts
        include ActionController::Rendering
        skip_before_action :validate_json_web_token, :is_freezed
        before_action :access_token
        def success_response
            fetch_payment
            execute_url = URI("#{ENV['PAYPAL_API_URL']}/v1/payments/payment/#{params[:paymentId]}/execute")
            https_execute = Net::HTTP.new(execute_url.host, execute_url.port);
            https_execute.use_ssl = true
            request_execute = Net::HTTP::Post.new(execute_url)
            request_execute["Accept"] = "application/json"
            request_execute["Content-Type"] = "application/json"
            request_execute["Authorization"] = "Bearer #{access_token}"
            body = "{
                \"payer_id\": \"#{params[:PayerID]}\"
            }"
            request_execute.body = body
            response = https_execute.request(request_execute)
            if response.code == "503"
                response.read_body == ""
            else
                @payment.customer_id = params[:PayerID]
                @payment.status = 2
                @payment.save
                res = JSON.parse(response.read_body.gsub('\"', '"'))
            end
        end

        def cancel_response
            @message = "cancelled payment"
        end

        private

        def fetch_payment
            @payment = Payment.where("charge_id = '#{params[:paymentId]}'").first
        end

        def access_token
            @client_id = ENV['PAYPAL_CLIENT_ID']
            @client_secret = ENV['PAYPAL_SECRET_KEY']
            environment = PayPal::SandboxEnvironment.new(@client_id, @client_secret)
            client = PayPal::PayPalHttpClient.new(environment)
            url = URI("#{ENV['PAYPAL_API_URL']}/v1/oauth2/token")

            https = Net::HTTP.new(url.host, url.port);
            https.use_ssl = true
            request = Net::HTTP::Post.new(url)
            request["Accept"] = "application/json"
            request["Accept-Language"] = "en_US"
            client_cred = @client_id + ":" + @client_secret
            #clent_id_secret = (%{ "#{Base64.encode64(clent_id_secret)}" }.squish).gsub(/\s+/, "")
            #request["Authorization"] = "Basic #{clent_id_secret}"
            client_id_secret = Base64.encode64(client_cred)
            basic = (client_id_secret).gsub("\n","")
            
            request["Authorization"] = "Basic #{basic}"
            request["Content-Type"] = "application/x-www-form-urlencoded"
            #request["Content-Type"] = "application/json"      
            request.body = "grant_type=client_credentials"
            response = https.request(request)
            if response.code == "503"
                response.read_body == ""
            else
                res = JSON.parse(response.read_body.gsub('\"', '"'))
                access_token = res["access_token"]
            end
        end
    end
end
