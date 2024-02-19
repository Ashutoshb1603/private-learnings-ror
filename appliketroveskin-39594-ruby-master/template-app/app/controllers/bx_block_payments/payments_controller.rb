module BxBlockPayments
    class PaymentsController < ApplicationController

        before_action :get_user, :except => [:execute, :membership_update, :ipn_webhook, :paypal_webhook]
        skip_before_action :validate_json_web_token, only: [:ipn_webhook, :paypal_webhook]
        skip_before_action :is_freezed, only: [:ipn_webhook, :paypal_webhook]

        # before_action :access_token, only: :submit
        @@wallet = BxBlockPayments::WalletsController.new
        @@paypal = BxBlockPayments::PaypalController.new
        @@currency_conversion = BxBlockPayments::CurrencyConversionController.new
        require 'json'
        require "uri"
        require "net/http"

        def upgrade_user
          plan_id = plan_params[:plan_id]
          plan = BxBlockPlan::Plan.find_by(id: plan_id)
          return render json: {message: "Plan not found"}, status: 404 if plan.nil?
          plan_type = 1
          time_period = plan.period == "month" ? plan.duration : plan.duration * 12
          payment = @customer.payments.create(plan_id: plan_id, status: "paid", charge_id: plan_params[:receipt_id], price_cents: (plan.price * 100), payment_gateway: "in_app")
          if plan.present?
            membership = @customer.membership_plans.where('end_date > ?', Time.now).first
            end_date_increase = (trial_params[:trial_available] == "true" or trial_params[:trial_available] == true) ? 7.days : time_period.months
            membership.end_date = membership.end_date + end_date_increase unless membership.nil?
            membership = @customer.membership_plans.create(start_date: Time.now, plan_type: plan_type,time_period: time_period, end_date: end_date_increase.after) if membership.nil?
            if membership.save!
              payload_data = {account: @customer, notification_key: 'home_page', inapp: true, push_notification: true, redirect: "home_page", key: 'plan'}
              BxBlockPushNotifications::FcmSendNotification.new("Thank you for investing in yourself. You are a Glowgetter and your journey to healthy skin will be fast-tracked and managed by us.", "Subscribed as Glowgetter", @customer.device_token, payload_data).call
              BxBlockPayments::PlanMailer.with(account: @customer, email: @customer.email).user_upgraded.deliver
            end
            render json: AccountBlock::AccountSerializer.new(@customer).serializable_hash
          end
        end

        def membership_update
          user_id = params[:user_id] || params[:userId]
          user = AccountBlock::Account.find_by(id: user_id)
          if user.present?
            membership = user.membership_plans.where('end_date > ?', Time.now).first
            membership = user.membership_plans.last if membership.nil?
            if membership.present? && membership.updated_at < 25.days.ago
              membership.end_date = membership.end_date + membership.time_period.months
              membership.save!
              render json: {message: "Membership updated successfully"}, status: 200
            else
              render json: {message: "Membership can't be updated"}, status: 200
            end
          end
        end   

        def my_wallet
            wallet = @@wallet.my_wallet(@customer)
            render json: BxBlockPayments::WalletSerializer.new(wallet).serializable_hash
        end

        def add_money
            prepare_new_payment
            @payment.payment_gateway = 0
            @payment.added_in_wallet = true
            if @customer.wallet.nil?
              currency = @customer.location&.downcase == "united kingdom" ? "gbp" : "eur"
              @customer.create_wallet(currency: currency)
            end
            BxBlockPayments::StripePayment.execute(payment: @payment, account: @customer, payment_for: "wallet") if @payment.currency == @customer.wallet.currency
            @payment.error_message = "Currency mismatch" if @payment.currency != @customer.wallet.currency
            if @payment&.save && @payment.paid?
                wallet = @@wallet.credit(@customer, params[:amount].to_d)
                payload_data = {account: @customer, notification_key: 'add_money_in_wallet', inapp: true, push_notification: true, redirect: 'wallet', key: 'wallet'}
                BxBlockPushNotifications::FcmSendNotification.new("We wish to let you know that you have successfully lodged funds to your wallet", "Money credited in wallet", @customer.device_token, payload_data).call
                WalletCreditMailer.with(account: @customer, email: @customer.email, amount: params[:amount]).add_money.deliver
                render json: BxBlockPayments::WalletSerializer.new(wallet).serializable_hash
            else
                render json: {errors: {message: @payment.error_message}},
                status: :unprocessable_entity
            end
        end

        def refund_money(user, payment, amount)
          @payment = payment
          amount_in_cents = (amount * 100).to_d
          code = 200
          if @payment.present? && amount.to_d <= (@payment.price_cents.to_d - @payment.refunded_amount.to_d)
            wallet_response = @@wallet.refund(user, amount.to_d)
            if wallet_response[:code] == 200
              stripe, error = BxBlockPayments::StripePayment.stripe_refund(amount: amount_in_cents, charge_id: @payment.charge_id)
              if stripe.present? && stripe.status == "succeeded"
                @payment.refunded_amount += amount
                @payment.save
                @refund = Refund.new(charge_id: @payment.charge_id, refund_id: stripe.id)
                @refund.save
                message = "Refunded #{amount} from your wallet"
                code = 200
              else
                wallet_response = @@wallet.reverse_refund(user, amount.to_d, wallet_response[:transaction_id])
                message = error.error.message
                code = 422
              end
            else
              message = wallet_response[:message]
              code = 422
            end
          else
            code = 422
            message = @payment.present? ? "Maximum allowed refund amount is #{@payment.price_cents - @payment.refunded_amount}": "Payment not found"
          end
          {message: message, code: code}
        end

        def pay_with_card
          return render json: { success: false, message: 'Please Add addres first.'}, status: 404 if @customer.addresses.blank?
          stripe_customer =  BxBlockPayments::StripePayment.find_or_create_customer(card_token: params[:card_id], customer: @customer)
          return render json: { success: false, message: 'Please update address first', error_message: "Address not found" }, status: 404 if !stripe_customer
          @payment = Payment.new(payment_params)
          @payment.account_id = @customer.id
          response, error = BxBlockPayments::StripePayment.pay_with_card(customer: @customer, params: card_params, payment: @payment)
          if @payment.save && @payment.paid?
            wallet = @@wallet.credit(@customer, card_params[:amount].to_d)
            payload_data = {account: @customer, notification_key: 'add_money_in_wallet', inapp: true, push_notification: true, redirect: 'wallet', key: 'wallet'}
            BxBlockPushNotifications::FcmSendNotification.new("We wish to let you know that you have successfully lodged funds to your wallet", "Money credited in wallet", @customer.device_token, payload_data).call
            WalletCreditMailer.with(account: @customer, email: @customer.email, amount: card_params[:amount]).add_money.deliver
          end
          if response.present?
            render json: BxBlockPayments::WalletSerializer.new(wallet).serializable_hash
          else
            render json: { success: false, message: "Could not make payemnt.", error_message: error}, status: 404
          end
        end

        def list_cards
          response = BxBlockPayments::StripePayment.new(@customer).list_all_cards
          if response.present?
            render json: { success: true, message: "listing of customer cards", data: {cards: response} }, status: 200
          else
            render json: { success: false, message: "Cards are not present.", data: {cards: response} }, status: 404
          end
        end

        def use_money
            response = @@wallet.debit(@customer, params[:amount].to_d)
            render json: {message: response[:message]}, :status => response[:code]
        end

        def send_gift
            email = gift_params["email_id"].downcase
            receiver = AccountBlock::Account.where('LOWER(email) = ?', email).first
            gift_sent = true
            if receiver.nil?
              gift_sent = false
              response = {message: "User doesn't exist. Try again.", errors: {message: "User doesn't exist. Try again."}, code: 422}
                # role =  BxBlockRolesPermissions::Role.find_by('lower(name) = :name', {name: (params[:data][:attributes][:role] || "User").downcase})
                # receiver = AccountBlock::InvitedAccount.create(first_name: 'invited', email: email, role_id: role&.id, password: 'password') if receiver.nil?
                # WalletCreditMailer.with(account: @customer, email: email, amount: gift_params[:amount]).invitation_email.deliver
            elsif @customer == receiver
              gift_sent = false
              response = {message: "Can't send gift to yourself!", errors: {message: "User doesn't exist. Try again."}, code: 422}
            elsif @customer.wallet.currency != receiver.wallet.currency
              gift_sent = false
              response = {message: "Currency mismatch. Try again.", errors: {message: "Currency mismatch. Try again."}, code: 422}
            elsif @customer.wallet.balance < gift_params[:amount].to_d
              gift_sent = false
              response = {message: "Insufficient balance. Try again.", errors: {message: "Insufficient balance. Try again."}, code: 422}
            end
            
            if gift_sent
              response = @@wallet.send_gift(@customer, receiver, gift_params)
              if response[:code] == 200
                payload_data_receiver = {notification_for: 'wallet_transaction', record_id: response[:data][:receiver_transaction].id ,account: receiver, notification_key: 'gift_received', inapp: true, push_notification: true, key: 'glow_gift'}
                gift_type = GiftType.find(gift_params[:gift_type_id])
                image = (gift_type&.free_user_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(gift_type.free_user_image, only_path: true) : "") if receiver.membership_plan[:plan_type] == "free"
                image = (gift_type&.gg_user_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(gift_type.gg_user_image, only_path: true) : "") if receiver.membership_plan[:plan_type] != "free"
                data = {
                  amount: gift_params[:amount],
                  custom_message: gift_params[:custom_message],
                  gift_type: gift_type&.name,
                  sender: @customer.email,
                  image: image
                }
                BxBlockPushNotifications::FcmSendNotification.new("How exciting, you have just received a glow gift!", "Gift received", receiver.device_token, payload_data_receiver, data).call if @customer.present?
                WalletCreditMailer.with(sender: @customer, email: gift_params["email_id"].downcase, amount: gift_params[:amount], message: gift_params[:custom_message]).gift_received.deliver
                payload_data_sender = {notification_for: 'wallet_transaction', record_id: response[:data][:sender_transaction].id, account: @customer, notification_key: 'gift_sent', inapp: true, push_notification: true, redirect: 'wallet', key: 'glow_gift'}
                BxBlockPushNotifications::FcmSendNotification.new("You have successfully sent a glow gift to #{receiver.name}", "Gift sent", @customer.device_token, payload_data_sender).call if receiver.present?
                WalletCreditMailer.with(receiver: receiver, email: @customer.email, amount: gift_params[:amount]).send_gift.deliver
              end
            end

            render json: response, :status => response[:code]
        end

        def thank_you
          account = AccountBlock::Account.find_by(email: params[:email])
          if account.present?
            first_name = account&.first_name
            payload_data = {notification_for: 'wallet_transaction', account: account, notification_key: 'thank_you', inapp: true, push_notification: true, key: 'glow_gift'}
            data = {
              amount: params[:amount]
            }
            BxBlockPushNotifications::FcmSendNotification.new("Dear #{first_name}, Thank you for the glow gift of #{params[:amount]}", "Thank you", account.device_token, payload_data, data).call 
          end
          render json: {message: "Message sent!"}, :status => 200
        end

        def submit
          @payment = nil
          #Check which type of payment it is
          if payment_params[:payment_gateway] == "stripe"
            prepare_new_payment
            @payment.payment_gateway = 0
            payment_for = payment_params[:plan_id].present? ? "membership" : "order"
            BxBlockPayments::StripePayment.execute(payment: @payment, account: @customer, payment_for: payment_for)
          elsif payment_params[:payment_gateway] == "wallet"
            prepare_new_payment
            @payment.payment_gateway = 2
            if @customer.wallet.present?
              wallet_balance = @customer.wallet.balance.to_d
              if @customer.wallet.currency == payment_params[:currency]
                amount_deduction_params = {status: 200, amount: params[:amount].to_d}
              else
                from = payment_params[:currency].upcase
                to = @customer.wallet.currency
                amount = params[:amount].to_d
                amount_deduction_params = @@currency_conversion.convert(from, to, amount)
              end
              if amount_deduction_params[:status] == 200 && wallet_balance > amount_deduction_params[:amount]
                payment = BxBlockPayments::Wallet.make_payment(@customer, @payment, amount_deduction_params[:amount])
              elsif amount_deduction_params[:status] == 200 && wallet_balance < amount_deduction_params[:amount]
                # remaining_amount = params[:amount].to_i - wallet_balance
                # payment = BxBlockPayments::Wallet.make_payment(@customer, @payment, wallet_balance)
                # @payment.update(price_cents: wallet_balance, status: "pending")
              render json: {errors: {message: "Insufficient Balance!"}},
               status: :unprocessable_entity
              else 
                render json: {errors: {message: amount_deduction_params[:message]}},
               status: :unprocessable_entity
              end
            end
          elsif payment_params[:payment_gateway] == "paypal"
            prepare_new_payment
            amount = params[:amount]
            payment_for = payment_params[:plan_id].present? ? "membership" : "order"
            description = "Payment for #{payment_for.capitalize} - @#{@customer.name} - #{@customer.email}"
            currency = payment_params[:currency].upcase
            paypal_response = @@paypal.create_payment(amount, currency, description)
            @payment.price_cents = params[:amount]
            @payment.payment_gateway = 1
            if paypal_response.success?
              @payment.charge_id = paypal_response.id
              @payment.status = "pending" 
            else
              @payment.status = "failed" 
              @payment.error_message = paypal_response.error["message"]
            end
          end

          if @payment&.save
            if @payment.paid?
              # Success is rendered when payment is paid and saved
              if payment_params[:plan_id].present?
                time_period = @payment.plan.interval == "year" ? 12 : 1
                upgrade_user(1, time_period)
                render json: @payment, status: :ok
              else
                #create order
                if params[:order].present?
                  response = create_order
                  order_status = JSON.parse(response.body)
                  if order_status['error'].present? || order_status['errors'].present?
                    if order_status['exception'].present?
                      render json: {errors: {message: order_status['exception']}}, status: response.message
                    elsif order_status['errors'].present?
                      render json: {errors: {message: order_status['errors']}}, status: response.message
                    end
                  else
                    render json: {data: {payment: @payment, order: order_status }}, status: :ok
                  end
                elsif params[:appointment].present?
                  response = create_appointment
                  appointment_status = JSON.parse(response.body)
                  if appointment_status['error'].present? || appointment_status['errors'].present?
                    if appointment_status['exception'].present?
                      render json: {errors: {message: appointment_status['exception']}}, status: response.message
                    elsif appointment_status['errors'].present?
                      render json: {errors: {message: appointment_status['errors']}}, status: response.message
                    end
                  else
                    render json: {data: {payment: @payment, appointment: appointment_status }}, status: :ok
                  end
                else
                  render json: @payment, status: :ok
                end
              end
              # elsif @payment.pending?
              #   render json: {data: {payment: @payment, remaining_amount: remaining_amount, payment_status: "pending"}}, status: :ok
            elsif @payment.pending? && payment_params[:payment_gateway] == 'paypal'
              render json: {data: {payment: @payment, paypal_response: paypal_response}}, status: :ok
            elsif @payment.failed? && !@payment.error_message.blank?
              payload_data = {account: @customer, notification_key: 'payment_failed', inapp: true, push_notification: true, redirect: 'wallet', key: 'wallet'}
              BxBlockPushNotifications::FcmSendNotification.new("Unfortunately your attempt to lodge funds to your wallet has failed, please check the details and try again", "Top up failed", @customer.device_token, payload_data).call
              # Render error only if payment failed and there is an error_message
              render json: {errors: {message: @payment.error_message}},
                status: :unprocessable_entity
            end
          end
        end

        def paypal_generate_token
          # paypal_customer =  @@paypal.create_customer(@customer) if @customer.paypal_customer_id.blank?
          # paypal_customer_id = paypal_customer.id || @customer.paypal_customer_id
          token = @@paypal.generate_token
          render json: {data: {token: token}}, status: :ok
        end

        def plans
          @plans = BxBlockPlan::Plan.all
          render json: BxBlockPayments::PlanSerializer.new(@plans).serializable_hash
        end

        def get_wallet_transaction
          @transactions = @customer.wallet_transactions.find(params[:id])
          render json: BxBlockPayments::WalletTransactionsSerializer.new(@transactions).serializable_hash
        end

        def execute
          payment_id = params[:paymentId]
          payer_id = params[:PayerID]
          @payment = BxBlockPayments::Payment.find_by(charge_id: payment_id)
          response = @@paypal.execute_payment(payment_id, payer_id)
          if response.success?
            @payment.update(status: "paid")
            render json: {data: {payment: @payment, paypal_response: response}}, status: :ok
          elsif response.state == "approved"
            render json: {data: {payment: @payment, paypal_response: response}}, status: :ok
          else
            render json: {errors: {message: response.error.message}},
              status: :unprocessable_entity
          end
        end


        def cancel
          render json: {success: false, message: "Payment cancelled!"}
        end


        def ipn_webhook
          payload = request.body.read
          signature = request.env["HTTP_STRIPE_SIGNATURE"]
          begin

            event = Stripe::Webhook.construct_event(
              payload, signature, ENV['STRIPE_WEBHOOK_ID']
            )
          rescue Stripe::SignatureVerificationError
            puts "Webhook signature verification failed"
            status 400
          end
          payment_method = event.data.object
          customer_id = payment_method.customer
          customer = AccountBlock::Account.find_by(stripe_customer_id: customer_id)
          case event.type
          when 'payment_intent.created'
            puts "payment created"
            payment = customer&.payments.where(charge_id: payment_params.id)&.last
            payment.update(status: "paid") if payment.present?
          when 'payment_intent.payment_failed'
            puts "payment failed"
            customer&.payments&.last&.update(status: "failed")
          when 'payment_intent.canceled'
            puts "payment canceled"
            customer&.payments&.last&.update(status: "failed")
          when 'payment_intent.succeeded'
            puts 'payment confirm'
            payment = customer&.payments.where(charge_id: payment_params.id)&.last
            payment.update(status: "paid") if payment.present?
          end
          status 200
        end



        def paypal_webhook
          webhook_id = ENV['PAYPAL_WEBHOOK_ID']
          event_body = request.body.read
          cert_url = request.headers['paypal-cert-url']
          actual_signature = request.headers['paypal-transmission-sig']
          transmission_id = request.headers['paypal-transmission-id']
          timestamp = request.headers['paypal-transmission-time']
          auth_algo = request.headers['paypal-auth-algo']
          paypal_event = @@paypal.verify_signature(transmission_id, timestamp, webhook_id, event_body, cert_url, actual_signature, auth_algo)
          event = event_body.event_type
          puts event
          puts "****"
          return {status: 200}
        end


        private
        def create_order
          token = request.headers[:token]
          url = base_url + "/bx_block_shopping_cart/orders"
          uri = URI(url)
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true if !(Rails.env.test?)
          request = Net::HTTP::Post.new(uri)
          request_params = Hash.new
          request_params["Content-Type"] = "application/json"
          request_params['accept'] = 'application/json'
          request_params["token"] = token
          request_params.each do |key, value|
              request[key] = value
          end
          body = {:order => order_params.to_h }
          request.body = body.to_json
          response = https.request(request)
        end

        def create_appointment
          token = request.headers[:token]
          url = base_url + "/bx_block_appointment_management/appointments"
          uri = URI(url)
          https = Net::HTTP.new(uri.host, uri.port)
          https.use_ssl = true if !(Rails.env.test?)
          request = Net::HTTP::Post.new(uri)
          request_params = Hash.new
          request_params["Content-Type"] = "application/json"
          request_params['accept'] = 'application/json'
          request_params["token"] = token
          request_params.each do |key, value|
              request[key] = value
          end
          body = {:data => appointment_params.to_h }
          request.body = body.to_json
          response = https.request(request)
        end

        # Initialize a new payment and and set its user, plan and price.

        def prepare_new_payment
          @payment = Payment.new(payment_params)
          @payment.account_id = @customer.id
          @plan = BxBlockPlan::Plan.find_by(id: @payment.plan_id)
          @payment.price_cents = @plan ? @plan.price : params[:amount]

        end

        # def fetch_payment
        #   @payment = Payment.where("account_id = #{@customer.id} and charge_id IS NOT NULL").last
        # end

        # def access_token
        #   @client_id = ENV['PAYPAL_CLIENT_ID']
        #   @client_secret = ENV['PAYPAL_SECRET_KEY']
        #   environment = PayPal::SandboxEnvironment.new(@client_id, @client_secret)
        #   client = PayPal::PayPalHttpClient.new(environment)
        #   url = URI("#{ENV['PAYPAL_API_URL']}/v1/oauth2/token")

        #   https = Net::HTTP.new(url.host, url.port);
        #   https.use_ssl = true
        #   request = Net::HTTP::Post.new(url)
        #   request["Accept"] = "application/json"
        #   request["Accept-Language"] = "en_US"
        #   client_cred = @client_id + ":" + @client_secret

        #   client_id_secret = Base64.encode64(client_cred)
        #   basic = (client_id_secret).gsub("\n","")

        #   request["Authorization"] = "Basic #{basic}"
        #   request["Content-Type"] = "application/x-www-form-urlencoded"
        #   request.body = "grant_type=client_credentials"
        #   response = https.request(request)
        #   if response.code == "503"
        #     response.read_body == ""
        #   else
        #     res = JSON.parse(response.read_body.gsub('\"', '"'))
        #     @access_token = res["access_token"]
        #   end
        # end




        def payment_params
          params.require(:payment).permit(:plan_id, :token, :payment_gateway, :charge_id, :currency)
        end

        def order_params
          params.require(:order).permit(:email, :phone, :address_id, :shipping_id, :transaction_id, :requires_shipping, cart_item_ids: [], discount_codes: [:id, :code, :amount, :type])
        end

        def appointment_params
          params.require(:appointment).permit(:datetime, :appointmentTypeID, :firstName, :lastName, :email, :calendarID, :phone, :age, :address, :transaction_id)
        end

        def card_params
          params.require(:payment).permit(:card_id, :amount, :description)
        end

        def gift_params
            params['data'].require('attributes').permit(:email_id, :amount, :custom_message, :gift_type_id)
        end

        def membership_plan_params
            params['data'].require('attributes').permit(:plan_type, :time_period)
        end

        def plan_params
          params["data"].require(:attributes).permit(:plan_id, :receipt_id)
        end

        def trial_params
          params['data'].require(:attributes).permit(:trial_available)
        end

        def get_user
            @customer = AccountBlock::Account.find(@token.id)
            render json: {errors: {message: 'Customer is invalid'}} and return unless @customer.present? or @token.account_type != "AdminAccount"
        end
    end
end
