module BxBlockPayments
    class SubscriptionsController < ApplicationController
        before_action :get_user
        @@wallet = BxBlockPayments::WalletsController.new

        def index
            @subscriptions = @user.subscriptions.where("is_cancelled = false").order('created_at DESC')
            if @subscriptions.present?
                render json: SubscriptionSerializer.new(@subscriptions).serializable_hash.merge(meta: {
                  message: "List of subscriptions."}), status: :ok
            else
                render json: {data:[], meta: {message: "List of subscriptions."}}, status: :ok
            end
        end
      
        def show
            @subscription = Subscription.find(params[:id])
            render json: SubscriptionSerializer.new(@subscription, meta: {
            message: "Success."}).serializable_hash, status: :ok
        end
      
        def create
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
            @subscription = @user.subscriptions.new(subscription_params)
            @subscription.currency = @user&.wallet&.currency || "eur"
            customer = AccountBlock::Account.find(@subscription.account_id)
            if customer&.stripe_customer_id.present?
                stripe_customer = Stripe::Customer.retrieve({ id: customer.stripe_customer_id })
                card = Stripe::Customer.retrieve_source(
                    stripe_customer.id,
                    stripe_customer.default_source,
                )
                @subscription.payment_from = card.brand + " - " + card.country
                if subscription_params[:frequency] == 'daily'
                    @subscription.next_payment_date = 1.days.from_now
                elsif subscription_params[:frequency] == 'weekly'
                    @subscription.next_payment_date = 7.days.from_now
                else
                    @subscription.next_payment_date = 30.days.from_now
                end
                if @subscription.save
                    
                    render json: SubscriptionSerializer.new(@subscription, meta: {
                        message: "Subscription created."}).serializable_hash, status: :created
                else
                    render json: {errors: {message: @subscription.errors.full_messages}},
                            status: :unprocessable_entity
                end
            else
                render json: {errors: {message: "Customer is not stripe customer."}},
                            status: 404
            end
        end
    
        def update
            @subscription = Subscription.find(params[:id])
            # if @subscription.update(amount: params[:subscription][:amount], frequency: params[:subscription][:frequency], is_cancelled: params[:subscription][:is_cancelled])
            if @subscription.update(subscription_params)
                if subscription_params[:frequency] == 'daily'
                    @subscription.update(next_payment_date: 1.days.from_now)
                elsif subscription_params[:frequency] == 'weekly'
                    @subscription.update(next_payment_date: 7.days.from_now)
                elsif subscription_params[:frequency] == 'monthly'
                    @subscription.update(next_payment_date: 30.days.from_now)
                end
                render json: SubscriptionSerializer.new(@subscription, meta: {
                message: "Subscription is updated."}).serializable_hash, status: :ok
            else
                render json: {errors: {message: @subscription.errors.full_messages}},
                        status: :unprocessable_entity
            end
        end

        private

        def subscription_params
          params.require(:subscription).permit(:frequency, :amount, :is_cancelled)
        end

        def get_user
            @user = AccountBlock::Account.find(@token.id)
            render json: {errors: {message: 'Customer is invalid'}} and return unless @user.present? or @token.account_type != "AdminAccount"
        end
    end
end
