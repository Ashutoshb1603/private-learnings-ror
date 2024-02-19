module BxBlockAdmin
  class UsersController < ApplicationController
    before_action :current_user

    def index
      users = AccountBlock::Account.where(role_id: BxBlockRolesPermissions::Role.find_by(name: "User")&.id)
      render json: UserSerializer.new(users).serializable_hash, status: :ok
    end

    def active
      if params[:ids].present?
        users = AccountBlock::Account.where(id: params[:ids])
        users.update_all(activated: true, is_deleted: false)
        render json: UserSerializer.new(users).serializable_hash, status: :ok
      else
        render :json => {'errors' => {"message" =>'Please pass ids of users to activate users'}}
      end
    end

    def block_or_unblock
      account = AccountBlock::Account.find(params["data"]["account_id"])
      account.toggle!(:blocked)
      if account.blocked
        render json: {message: 'User blocked successfully!'}
      else
        render json: {message: 'User unblocked successfully!'}
      end
    end

    def upgrade_membership
      BxBlockCustomisableusersubscriptions::MembershipPlan.where('account_id in (?) and end_date >= ?', params["data"]["account_ids"], Time.now).update(plan_type: "elite")
      accounts = AccountBlock::Account.where(id: params["data"]["account_ids"])
      registration_ids = accounts.map(&:device_token)
      payload_data = {account_ids: accounts.map(&:id), notification_key: 'home_page', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'membership_upgrade', key: 'membership_upgrade'}
      BxBlockPushNotifications::FcmSendNotification.new("Thank you for investing in you and in us. In recognition of your commitment to Skin Deep and Monica Tolan The Skin Experts, we have elevated you to Elite Glowgetter status.", "Elite Glowgetter", registration_ids, payload_data).call
      render json: {message: 'Users upgraded successfully!'}
    end

    def downgrade_membership
      BxBlockCustomisableusersubscriptions::MembershipPlan.where('account_id in (?) and end_date >= ?', params["data"]["account_ids"], Time.now).update(plan_type: "glow_getter")
      accounts = AccountBlock::Account.where(id: params["data"]["account_ids"])
      registration_ids = accounts.map(&:device_token)
      payload_data = {account_ids: accounts.map(&:id), notification_key: 'home_page', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'membership_upgrade', key: 'membership_upgrade'}
      BxBlockPushNotifications::FcmSendNotification.new("We wish to notify you that you no longer meet the criteria of Elite Glowgetter status. We look forward to continued relations with you as a Glowgetter.", "You no longer meet the criteria of Elite Glowgetter status", registration_ids, payload_data).call
      render json: {message: 'Users downgraded successfully!'}
    end

    def elite_eligible_users
      plan_type_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types["glow_getter"]
      glow_getter_users = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, plan_type_value)
      # glow_getter_users = accounts.reject {|account| account.membership_plan[:plan_type] != "glow_getter"}
      
      conditions = EliteEligibility.all
      eligible = []

      glow_getter_users.each do |user|
        conditions.each do |condition|
          is_eligible = true
          if condition.interval == "lifetime" and condition.eligibility_on == "money_spent"
            is_eligible = user&.orders&.sum(:total_price) >= condition.value
          elsif condition.eligibility_on == "product_bought" and condition.interval != "lifetime"
            for i in 1..condition.frequency do 
              start_interval = (i * condition.time).send(condition.interval).ago.end_of_day
              end_interval = ((i-1)*condition.time).send(condition.interval).ago.beginning_of_day
              is_eligible = user.orders.joins(:line_items).
                              where("shopping_cart_orders.created_at >= ? and shopping_cart_orders.created_at <= ? and line_items.name ilike '%#{condition.product_type}%'",
                              start_interval, end_interval).present?
              
            end
          end
          eligible << user if is_eligible
          break if is_eligible
        end
      end
      render json: TopSpendersSerializer.new(eligible)
    end

    def inactive
      if params[:ids].present?
        users = AccountBlock::Account.where(id: params[:ids])
        users.update_all(activated: false, is_deleted: true)
        render json: UserSerializer.new(users).serializable_hash, status: :ok
      else
        render :json => {'errors' => {"message" =>'Please pass ids of users to inactivate users'}}
      end
    end
  end
end