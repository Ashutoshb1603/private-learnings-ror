ActiveAdmin.register AccountBlock::Account, as: "User" do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  menu label: "Active Users", priority: 1
  filter :first_name
  filter :last_name
  filter :email
  filter :gender
  filter :activated
  filter :device, as: :select, collection: ["android", "ios"]

  batch_action :inactive_all do |ids|
    AccountBlock::Account.where(id: ids).update_all(activated: false, is_deleted: true)
    redirect_to collection_path, notice: 'All selected users was inactivated successfully.'
  end

  batch_action :active_all do |ids|
    AccountBlock::Account.where(id: ids).update_all(activated: true, is_deleted: false)
    redirect_to collection_path, notice: 'All selected users was activated successfully.'
  end

  csv do
    column :first_name
    column :last_name
    column :full_phone_number
    column :gender
    column :country_code
    column :phone_number
    column :email
    column :activated
    column :device
    column :membership_plan do |object|
      object&.membership_plan[:plan_type]&.humanize
    end
    column "Created At/Terms & Conditions Accepted At:" do |object|
      object.created_at.getlocal.strftime("%d %B %Y %H:%M:%S")
    end
  end

  collection_action :bulk_create, method: :post do
    emails = params["email_ids"].split(/[ |, |,|\n|\r]+/)
    details = params["email_ids"].split("\r\n")
    details.each do |detail|
      data = detail.split(" ")
      email = data.last
      first_name, last_name = "", ""
      first_name = data.first if data.count > 1
      last_name = data.second if data.count == 3
      last_name = data.third if data.count == 4
      random_password = SecureRandom.hex(4)
      role_id = BxBlockRolesPermissions::Role.find_by('lower(name) = ?', 'user').id
      next unless AccountBlock::EmailValidation.new(email).valid?
      if !AccountBlock::EmailAccount.where('LOWER(email) = ?', email.downcase).first.present?
        account = AccountBlock::EmailAccount.create(first_name: first_name, last_name: last_name, email: email, password: random_password, role_id: role_id, activated: true)
        account.membership_plans.create(plan_type: 'glow_getter', start_date: Time.now, end_date: (Time.now + 90.days).end_of_day)
        AccountBlock::AccountMailer.with(account: account, password: random_password).user_onboarding.deliver
      end
    end
    flash[:notice] = "Users added!"
    redirect_to admin_users_onboarding_path
  end

  collection_action :send_elite_invite, method: [:get] do
    role =  BxBlockRolesPermissions::Role.find_by('lower(name) = :name', {name: ("User").downcase})
    receiver = AccountBlock::Account.where('LOWER(email) = ?', params[:email].downcase).first
    if receiver.present? and receiver.type != "InvitedAccount"
      receiver.membership_plan.update(plan_type: 'elite') if receiver.membership_plan[:plan_type] != "free"
      receiver.membership_plans.create(plan_type: 'elite', start_date: Time.now, end_date: (Time.now + 90.days).end_of_day) if receiver.membership_plan[:plan_type] == "free"
      payload_data = {account: receiver, notification_key: 'home_page', inapp: true, push_notification: true, type: 'admin', redirect: "home_page", key: "plan"}
      BxBlockPushNotifications::FcmSendNotification.new("Thank you for investing in you and in us. In recognition of your commitment to Skin Deep and Monica Tolan The Skin Experts, we have elevated you to Elite Glowgetter status.", "You are now an Elite Glowgetter", receiver.device_token, payload_data).call
      AccountBlock::EliteInviteMailer.with(email: params[:email], plan_type: 'elite').upgrade_email.deliver
    elsif receiver.nil?
      receiver = AccountBlock::InvitedAccount.create(first_name: 'invited', last_name: 'user', email: params[:email], role_id: role&.id, password: 'password')
      receiver.membership_plans.create(plan_type: 'elite')
      AccountBlock::EliteInviteMailer.with(email: params[:email], plan_type: 'elite').invitation_email.deliver
    end
    
    redirect_to admin_invite_elite_glowgetter_path 
  end

  collection_action :add_money, method: [:put] do
    amount = params[:added_amount].to_f
    account = AccountBlock::Account.find(params[:id].to_i)
    wallet = BxBlockPayments::WalletsController.new
    if account.wallet.present?
      wallet.credit(account, params[:added_amount].to_d)
    else
      currency = account.location.downcase == "united kingdom" ? "gbp" : "eur"
      account.create_wallet(currency: currency)
      wallet.credit(account, params[:added_amount].to_d)
    end
    payload_data = {account: account, notification_key: 'add_money_in_wallet', inapp: true, push_notification: true, redirect: 'wallet', key: 'wallet'}
    BxBlockPushNotifications::FcmSendNotification.new("We wish to let you know that we have successfully lodged funds to your wallet", "Money credited in wallet", account.device_token, payload_data).call
    flash[:message] = "Amount successfully updated."
    redirect_to admin_user_path(account)
  end

  collection_action :send_glowgetter_invite, method: [:get] do
    role =  BxBlockRolesPermissions::Role.find_by('lower(name) = :name', {name: ("User").downcase})
    receiver = AccountBlock::Account.where('LOWER(email) = ?', params[:email].downcase).first
    if receiver.present? and receiver.type != "InvitedAccount"
      downgraded = receiver.membership_plan[:plan_type] == "elite"
      receiver.membership_plan.update(plan_type: 'glow_getter') if receiver.membership_plan[:plan_type] != "free"
      receiver.membership_plans.create(plan_type: 'glow_getter', start_date: Time.now, end_date: (Time.now + 30.days).end_of_day) if receiver.membership_plan[:plan_type] == "free"
      payload_data = {account: receiver, notification_key: 'subscribed_to_glowgetter', inapp: true, push_notification: true, type: 'admin', redirect: "home_page", key: "plan"}
      message = "Thank you for investing in yourself. You are a Glowgetter and your journey to healthy skin will be fast-tracked and  managed by us."
      title = "You are now a Glowgetter."
      message = "We wish to notify you that you no longer meet the criteria of Elite Glowgetter status. We look forward to continued relations with you as a Glowgetter." if downgraded
      title = "You no longer meet the criteria of Elite Glowgetter status" if downgraded
      BxBlockPushNotifications::FcmSendNotification.new(message, title, receiver.device_token, payload_data).call
      AccountBlock::EliteInviteMailer.with(email: params[:email], plan_type: 'glow_getter').upgrade_email.deliver if !downgraded
      AccountBlock::EliteInviteMailer.with(email: params[:email]).downgrade_email.deliver if downgraded
    elsif receiver.nil?
      receiver = AccountBlock::InvitedAccount.create(first_name: 'invited', last_name: 'user', email: params[:email], role_id: role&.id, password: 'password')
      receiver.membership_plans.create(plan_type: 'glow_getter')
      AccountBlock::EliteInviteMailer.with(email: params[:email], plan_type: 'glow_getter').invitation_email.deliver
    end
    
    redirect_to admin_invite_elite_glowgetter_path 
  end

  collection_action :refund, method: :put do
    account = AccountBlock::Account.find(params[:id])
    amount = params["refund_amount"].to_f
    if account.present? && account&.wallet&.balance.to_d >= amount
      payments_controller = BxBlockPayments::PaymentsController.new
      payment = account.payments.find_by(id: params[:payment_id])
      response = payments_controller.refund_money(account, payment, amount)
    else
      response = {message: "Insufficient balance", code: 422}
    end
    if response[:code] == 200
      payload_data = {account: account, notification_key: 'refund', inapp: true, push_notification: true, type: 'admin', redirect: "home_page", key: "wallet"}
      BxBlockPushNotifications::FcmSendNotification.new("Refund initiated.", "Hi #{account&.first_name&.titleize}, €#{amount} has been refunded back to your account.", account.device_token, payload_data).call
      redirect_to admin_user_path(account), notice: response[:message]
    else
      redirect_to admin_user_path(account), alert: response[:message]
    end
  end

  member_action :update_status, method: [:put, :patch] do
    resource.update(is_deleted: resource.is_deleted ? false : true)
    redirect_to resource_path, notice: "User was successfully #{resource.is_deleted ? "inactivated" : "activated"}."
  end

  actions :all, :except => [:new, :create]
  permit_params :full_phone_number, :country_code, :phone_number, :email, :activated, :type, :role_id, :name
  #
  # or
  #
  permit_params do
    permitted = [:full_phone_number, :country_code, :phone_number, :email, :activated, :type, :role_id, :first_name, :last_name, :gender, membership_plans_attributes: [:id, :end_date]]
    permitted << :other if params[:action] == 'create' && current_admin_user
    permitted
  end
  
  index do
    selectable_column
    column :name
    column :country_code
    column :phone_number
    column :email
    column :gender
    column :activated
    column :device
    column "Wallet Balance" do |user|
      user&.wallet&.balance.to_f || 0.0
    end
    column :membership_plan do |user|
      div class: "#{user.membership_plan[:plan_type]}" do 
        user.membership_plan[:plan_type].humanize
      end
    end
    column "Membership Start Date" do |user|
      user.membership_plan[:plan_type]!= "free" ? user.membership_plan[:start_date] : "N/A"
    end
    column "Membership End Date" do |user|
      user.membership_plan[:plan_type]!= "free" ? user.membership_plan[:end_date] : "N/A"
    end
    actions defaults: false do |user|
      item "View", admin_user_path(user), class: "member_link"
      item "Edit", edit_admin_user_path(user), class: "member_link"
      item user.activated ? "Inactive" : "Active", update_status_admin_user_path(user), method: :put, class: "member_link"
    end
  end

  show do |object|
    attributes_table do
      row "Active/Inactive User" do
        status = object.activated? ? 'Deactivate' : 'Activate'
        link_to user.activated ? "Inactive" : "Active", update_status_admin_user_path(user), method: :put, class: "link", :data => { :confirm => "Are you sure to #{status} this user?"}
      end
      row :id
      row :name
      row :full_phone_number
      row :country_code
      row :phone_number
      row :email
      row :gender
      row :activated
      row :device
      row :role
      row :location
      row "Wallet Balance" do
        div object.wallet&.balance || 0
      end
      row "Created at/Terms & Conditions accepted at:" do 
        object.created_at.getlocal
      end
      row "Upgrade to Elite" do
        object.membership_plan[:plan_type] == "elite" ? "Already an Elite" : (link_to "Upgrade To Elite", send_elite_invite_admin_users_path(email: user.email), class: "link")
      end
      row "Upgrade to glowgetter" do
        object.membership_plan[:plan_type] == "glow_getter" ? "Already a Glowgetter" : (link_to "#{object.membership_plan[:plan_type] == "elite" ? "Downgrade" : "Upgrade"} To Glowgetter", send_glowgetter_invite_admin_users_path(email: user.email), class: "link")
      end
      div class: 'add_money_in_wallet' do
        h3 'Add money to wallet'
        table do
          tr do
            td do
              render partial: "add_money", locals: {user: object}
            end
          end
        end
      end
      currency = object.wallet&.currency || (object.location.downcase == "ireland" ? "eur" : "gbp")
      payments = object.payments.where(added_in_wallet: true, status: 'paid', currency: currency).order(created_at: :desc)
      if payments.present?
        div class: "refund_amount" do
          h3 'Payments & Refunds'
          table do
            th "Payment Amount"
            th "Refunded Amount"
            th "Max Refund Allowed"
            th "Refund Amount"
            payments.each do |payment|
              allowed_refund_amount = (payment&.price_cents.to_d - payment&.refunded_amount.to_d) || 0
              allowed_refund_amount = allowed_refund_amount > user.wallet&.balance.to_d ? user.wallet&.balance.to_d : allowed_refund_amount
              if allowed_refund_amount > 0
                tr do
                  td payment.price_cents.to_d
                  td payment.refunded_amount.to_d
                  td allowed_refund_amount
                  td do
                    render partial: "refund_amount", locals: {user: user, payment: payment}
                  end
                end
              end
            end
          end
        end
      end

      subscriptions = object.membership_plans
      if subscriptions.present?
        div do
          h3 'Subscription History'
          table do
            th "Plan Type"
            th "Start Date"
            th "End Date"
            subscriptions.each do |subscription|
              tr do
                td subscription.plan_type
                td subscription.start_date
                td subscription.end_date
              end
            end
          end
        end
      end


    end
  end

  form do |f|
    f.inputs  do
      f.input :first_name
      f.input :last_name
      f.input :gender, as: :select, collection: AccountBlock::Account.genders.keys, prompt: "Select Gender"
      f.input :activated
      f.input :full_phone_number
      f.input :email
      f.has_many :membership_plans, new_record: false, heading: false do |a|
        a.input :end_date, as: :datetime_picker, label: 'Membership End Date'
      end
    end
    f.actions do
      f.action :submit, as: :input, label: 'Update User'
      f.cancel_link({action: "index"})
    end
  end

  controller do
    def update
      @user = AccountBlock::Account.find_by(id: params[:id])
      if @user.update(permitted_params["account"])
        flash[:notice] = "User was successfully updated."
        redirect_to @user.user? ? admin_user_path(@user) : admin_therapist_path(@user)
      else
        flash.now[:error] = @user.errors.full_messages.join(", ")
        render :edit
      end
    end

    def scoped_collection
      AccountBlock::Account.unscoped.where(role_id: BxBlockRolesPermissions::Role.find_by(name: "User")&.id)
    end
  end
end
