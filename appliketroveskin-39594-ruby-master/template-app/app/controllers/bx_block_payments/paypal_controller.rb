module BxBlockPayments
    class PaypalController < ApplicationController
        require 'paypal-sdk-rest'
        include PayPal::SDK::REST
        def initialize
            PayPal::SDK::REST.set_config(
            :mode => ENV["MODE"],
            :client_id => ENV["PAYPAL_CLIENT_ID"],
            :client_secret => ENV["PAYPAL_SECRET_KEY"],
            :ssl_options => {ca_file: nil})
        end

        def verify_signature(transmission_id, timestamp, webhook_id, event_body, cert_url, actual_signature, auth_algo)
            begin
                valid = PayPal::SDK::REST::WebhookEvent.verify(transmission_id, timestamp, webhook_id, event_body, cert_url, actual_signature, auth_algo)
            rescue PayPal::SignatureVerificationError
                puts "Webhook paypal signature verification failed"
                return false
            end
            valid
        end

        def create_payment(amount, currency="EUR", description="")
            payment = PayPal::SDK::REST::Payment.new({
                :intent => "sale",
                :payer => {
                    :payment_method => "paypal" },
                :redirect_urls => {
                    :return_url => "#{ENV["BASE_URL"]}/bx_block_payments/payments/execute",
                    :cancel_url => "#{ENV["BASE_URL"]}/bx_block_payments/payments/cancel" },
                :transactions => [{
                    :amount => {
                        :total => amount,
                        :currency => currency },
                    :description => description }]})
            payment.create
            return payment
        end

        def execute_payment(payment_id, payer_id)
            payment = PayPal::SDK::REST::Payment.find(payment_id)
            payment.execute( :payer_id => payer_id )
            return payment
        end

        def get_payment(payment_id)
            payment = PayPal::SDK::REST::Payment.find(payment_id)
        end

    end
end