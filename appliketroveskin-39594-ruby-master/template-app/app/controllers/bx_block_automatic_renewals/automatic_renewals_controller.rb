module BxBlockAutomaticRenewals
    class AutomaticRenewalsController < ApplicationController
        include BuilderJsonWebToken::JsonWebTokenValidation
        before_action :current_user

        def index
            @auto_renewals = AutomaticRenewal.all
            if @auto_renewals.present?
                render json: AutomaticRenewalSerializer.new(@auto_renewals, meta: {
                    message: "List of automatic renewals."}).serializable_hash, status: :ok
            else
                render json: {errors: {message: 'No automatic renewals.'}}, status: :ok
            end
        end

        def show
            @auto_renewal = AutomaticRenewal.find(params[:id])
            render json: AutomaticRenewalSerializer.new(@auto_renewal, meta: {
                message: "Success."}).serializable_hash, status: :ok
        end

        def create
            @auto_renewal =
              AutomaticRenewal.new(auto_renew_params.merge(account_id: @current_user.id))
            if @auto_renewal.save
                render json: AutomaticRenewalSerializer.new(@auto_renewal, meta: {
                message: "Automatic Renewals turned on."}).serializable_hash, status: :created
            else
                render json: {errors: {message: @auto_renewal.errors.full_messages}},
                status: :unprocessable_entity
            end
        end

        def update
            @auto_renewal = AutomaticRenewal.find_by(id: params[:id], account_id: @current_user.id)
            if @auto_renewal.present?
                @auto_renewal.is_auto_renewal = params[:auto_renew][:is_auto_renewal]
                if @auto_renewal.save
                    render json: AutomaticRenewalSerializer.new(@auto_renewal, meta: {
                    message: "Automatic Renewals updated."}).serializable_hash, status: :ok
                else
                    render json: {errors: {message: @auto_renewal.errors.full_messages}},
                    status: :unprocessable_entity
                end
            else
                render json: {message: "Record not found."},
                status: :unprocessable_entity
            end
        end

        private
        def auto_renew_params
            params.require(:auto_renew).permit(:subscription_type, :is_auto_renewal)
        end
    end
end
