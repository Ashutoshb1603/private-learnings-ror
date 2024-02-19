module BxBlockPayments
  class PlansController < ApplicationController
    before_action :get_plan, only: [:show, :update, :destroy]
    before_action :get_user

    def index
      @plans = BxBlockPlan::Plan.all
      render json: BxBlockPayments::PlanSerializer.new(@plans).serializable_hash, status: :ok
    end

    def show
      return if @plan.nil?
      render json: BxBlockPayments::PlanSerializer.new(@plan).serializable_hash,
             status: :ok
    end

    def create
      stripe = Stripe::Plan.create({
        amount_decimal: plans_params[:price_cents],
        interval: plans_params[:interval],
        product: {
          name: plans_params[:name],
        },
        currency: 'eur',
        id: plans_params[:stripe_plan_name],
      })

      @plan = BxBlockPlan::Plan.new(plan_params) if stripe

      if @plan.save
        render json: BxBlockPayments::PlanSerializer.new(@plan).serializable_hash,
               status: :created
      else
        render json: {errors: {message: @plan.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def destroy
      return if @plan.nil?
      stripe = Stripe::Plan.delete(
        plans_params[:stripe_plan_name],
      )

      begin
        if stripe.deleted && @plan.destroy
          render json: { success: true }, status: :ok
        end
      rescue ActiveRecord::InvalidForeignKey
        message = "Plan can't be deleted"

        render json: {
          errors: { message: message }
        }, status: :internal_server_error
      end
    end

    def update
      return if @plan.nil?
      stripe = Stripe::Plan.delete(
        @plan.stripe_plan_name,
      )
      if stripe.deleted
        stripe = Stripe::Plan.create({
          amount_decimal: plan_params[:price_cents],
          interval: plan_params[:interval],
          product: {
            name: plan_params[:name],
          },
          currency: 'eur',
          id: @plan.stripe_plan_name,
        })
      else
        message = "Plan can't be deleted"

        render json: {
          errors: { message: message }
        }, status: :internal_server_error
      end

      if stripe
        update_result = @plan.update(plan_params)
      end
      if update_result
        render json: BxBlockPayments::PlanSerializer.new(@plan).serializable_hash,
               status: :ok
      else
        render json: {errors: {message: @plan.errors.full_messages}},
               status: :unprocessable_entity
      end
    end


    private

    def get_user
        @customer = AccountBlock::Account.find(@token.id)
        render json: {errors: {message: 'Customer is invalid'}} and return unless @customer.present? or @token.account_type != "AdminAccount"
    end

    def get_plan
      @plan = BxBlockPlan::Plan.find_by(id: params[:id])
    end

    def plan_params
      params.require(:plan).permit(:price, :name, :duration, :period)
    end

    def plans_params
      params.require(:plan).permit(:price_cents, :name, :stripe_plan_name, :interval)
    end

  end
end
