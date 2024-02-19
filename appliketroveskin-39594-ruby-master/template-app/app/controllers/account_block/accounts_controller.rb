module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, only: [:renew_token, :update, :user_details, :delete_account, :logout, :subscribe, :unsubscribe, :freeze_account, :unfreeze_account, :delete_confirmation_message, :destroy, :contact_us, :skin_journey, :add_sign_in_time, :add_sign_out_time]
    before_action :set_account, only: [:renew_token, :update, :user_details, :delete_account, :logout, :subscribe, :unsubscribe, :freeze_account, :unfreeze_account, :delete_confirmation_message, :destroy, :contact_us, :skin_journey, :add_sign_in_time, :add_sign_out_time]
    before_action :check_valid_user, only: [:renew_token, :update, :user_details, :delete_account, :logout, :subscribe, :unsubscribe, :freeze_account, :unfreeze_account, :delete_confirmation_message, :destroy, :skin_journey, :add_sign_in_time, :add_sign_out_time]
    @@klaviyo = BxBlockKlaviyointegration::KlaviyoController.new
    @@silent_job = BxBlockNotifications::SilentNotificationJob

    def create
      role =  BxBlockRolesPermissions::Role.find_by('lower(name) = :name', {name: (params[:data][:attributes][:role] || "User").downcase})
      params[:data][:attributes].merge!(role_id: role&.id)
      params[:data][:attributes].delete(:role)
      case params[:data][:type] #### rescue invalid API format
      when 'sms_account'
        validate_json_web_token

        unless valid_token?
          return render json: {errors:
            {message: 'Invalid Token', token: 'Invalid Token'}
          }, status: :bad_request
        end

        begin
          @sms_otp = SmsOtp.find(@token[:id])
        rescue ActiveRecord::RecordNotFound => e
          return render json: {errors:
            {message: 'Confirmed Phone Number was not found'}
          }, status: :unprocessable_entity
        end

        params[:data][:attributes][:full_phone_number] =
          @sms_otp.full_phone_number
        @account = SmsAccount.new(jsonapi_deserialize(params))
        @account.activated = true
        if @account.save
          render json: SmsAccountSerializer.new(@account, meta: {
            token: update_jwt_token(@account)
          }).serializable_hash, status: :created
        else
          render json: {errors: {message: @account.errors.full_messages}},
            status: :unprocessable_entity
        end

      when 'email_account'
        account_params = jsonapi_deserialize(params)

        query_email = account_params['email'].downcase
        account = Account.where('LOWER(email) = ?', query_email).first

        validator = EmailValidation.new(account_params['email'])
        return render json: {errors:
          {message: account ? 'Email is already in use' : 'Email invalid'}
        }, status: :unprocessable_entity if (account && account.type != "InvitedAccount") || !validator.valid?

        
        if (account.present? && account.type == "InvitedAccount")
          @account = account
          @account.assign_attributes(jsonapi_deserialize(params))
          @account.type = "EmailAccount"
          @account.activated = true
          @account.membership_plans.first.update(start_date: Time.now, end_date: Time.now + 1.month) if @account.membership_plans.present?
        else
          @account = EmailAccount.new(jsonapi_deserialize(params))
        end
        if @account.save
          @account = AccountBlock::EmailAccount.find(@account.id)
          token = update_jwt_token(@account)
          @account.send_confirmation_mail(request.base_url, token) unless @account.activated
          if @account.is_subscribed_to_mailing
            klaviyo = BxBlockKlaviyointegration::KlaviyoController.new
            klaviyo_list = JSON.parse(klaviyo.get_list)
            list_id = ""
            membership_list_id = ""
            new_list_id = ""
            klaviyo_list.each do |item|
              if item["list_name"] == "skin_deep_app"
                list_id = item["list_id"]
              elsif item["list_name"] == "skin_deep_app_free_users"
                membership_list_id = item["list_id"]
              elsif item["list_name"] == "skin_deep_app_new_users"
                new_list_id = item["list_id"]
              end
            end

            list_id = JSON.parse(klaviyo.create_list("skin_deep_app"))["list_id"] if list_id.blank?
            membership_list_id = JSON.parse(klaviyo.create_list("skin_deep_app_free_users"))["list_id"] if membership_list_id.blank?
            new_list_id = JSON.parse(klaviyo.create_list("skin_deep_app_new_users"))["list_id"] if new_list_id.blank?

            klaviyo.create_subscriber(list_id, {"email": "#{@account.email}"})
            klaviyo.create_subscriber(membership_list_id, {"email": "#{@account.email}"})
            klaviyo.create_subscriber(new_list_id, {"email": "#{@account.email}"})
            kalviyo_list = @account.build_klaviyo_list(membership_list: 'free', new: true) if @account.klaviyo_list.blank?
            kalviyo_list.save if kalviyo_list.present?
          end
          render json: EmailAccountSerializer.new(@account, meta: {
            token: token,
            activated: @account.activated
          }).serializable_hash, status: :created
        else
          render json: {errors: {message: @account.errors.full_messages}},
            status: :unprocessable_entity
        end

      when 'social_account'
        @account = SocialAccount.new(jsonapi_deserialize(params))
        @account.password = @account.email
        if @account.save
          render json: SocialAccountSerializer.new(@account, meta: {
            token: update_jwt_token(@account),
          }).serializable_hash, status: :created
        else
          render json: {errors: {message: @account.errors.full_messages}},
            status: :unprocessable_entity
        end

      else
        render json: {errors:
          {message: 'Invalid Account Type'}
        }, status: :unprocessable_entity
      end
    end

    def show
      @account = EmailAccount.find_by(email: params[:email])
      if @account
        render json: {account: "Account with #{params[:email]} is registered"}, status: :ok
      else
        render json: {errors:
          {message: "This email is not registered on our system"}
        }, status: :unprocessable_entity
      end
    end

    def update
      return if @account.nil?
      if update_account_params[:location].present? && @account.location != update_account_params[:location]
        @account.cart_items.destroy_all 
        @@silent_job.perform_now(@current_user, false)
      end
      update_result = @account.update(update_account_params)
      if update_account_params[:password].present?
        payload_data = {account: @account, notification_key: 'update_password', inapp: true, push_notification: false, redirect: "home_page", key: "profile"}
        BxBlockPushNotifications::FcmSendNotification.new("You have successfully changed your password!", "Password changed", @account.device_token, payload_data).call
      end
      if update_result
        type = @account.type
        render json: "AccountBlock::#{type}Serializer".constantize.new(@account)
                         .serializable_hash,
               status: :ok
      else
        render json: {errors: {message: @account.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def user_details
      type = @account.type
      render json: "AccountBlock::#{type}Serializer".constantize.new(@account).serializable_hash,
               status: :ok
    end

    def delete_account
      update_result = @account.update(is_deleted: true)

      if update_result
      payload_data = {account: @account, notification_key: 'home_page', inapp: true, push_notification: true, redirect: "signup_page", key: "account"}
        BxBlockPushNotifications::FcmSendNotification.new("You have successfully changed your password!", "Account deleted", @account.device_token, payload_data).call
        AccountMailer.with(account: @account, email: @account.email).delete_account.deliver
        render json: {data: {message: "User deleted successfully."}}, status: :ok
      else
        render json: {errors: {message: @account.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def contact_us
      @account.update(contact_us_primary_image: params[:primary_image]) if params[:primary_image].present?
      @account.update(contact_us_secondary_image: params[:secondary_image]) if params[:secondary_image].present?
      AccountMailer.with(params: params, account: @account).contact_us.deliver
      render json: {data: {message: "Mail sent"}}, status: :ok
    end

    def logout
      update_result = @account.update(jwt_token: nil, device_token: nil)
      if update_result
        render json: {data: {message: "User logged out successfully."}}, status: :ok
      else
        render json: {errors: {message: @account.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def delete_confirmation_message
      balance = @account&.wallet&.balance || 0
      message = balance != 0 ? 
                  "You've money in your wallet, if you delete your account you will lose your wallet balance, are you sure you want to delete your account?" :
                   "You are about to delete your account, are you sure?"
      render json: {message: message}
    end

    def destroy
      token = BuilderJsonWebToken.encode(@account.id, {exp: 15.minutes.from_now.to_i, destroy: true})
      AccountMailer.with(account: @account, email: @account.email, token: token).delete_confirmation.deliver
      render json: {message: 'Email sent with delete confirmation link'}, status: :ok
    end

    def renew_token
      token = update_jwt_token(@account, @account.type)
      type = @account.type
      render json: "AccountBlock::#{type}Serializer".constantize.new(@account, meta: {
        token: token,
      }).serializable_hash
    end

    def subscribe
      list_id = klaviyo_list_id("skin_deep_app")
      response = @@klaviyo.create_subscriber(list_id, {"email": "#{@account.email}"})
      membership = @account.membership_plan[:plan_type]
      membership_list = 'skin_deep_app_free_users'
      case membership
      when 'free'
        membership_list = 'skin_deep_app_free_users'
      when 'glow_getter'
        membership_list = 'skin_deep_app_glow_getter_users'
      when 'elite'
        membership_list = 'skin_deep_app_elite_users'
      end
      
      membership_list_id = klaviyo_list_id(membership_list)
      response = @@klaviyo.create_subscriber(membership_list_id, {"email": "#{@account.email}"})

      purchased_academy = @account.customer_academy_subscriptions.present?
      if purchased_academy
        academy_list_id = klaviyo_list_id('skin_deep_app_academy_users')
        response = @@klaviyo.create_subscriber(academy_list_id, {"email": "#{@account.email}"})
      end
      klaviyo_obj = @account.build_klaviyo_list if @account.klaviyo_list.blank?
      klaviyo_obj.save if klaviyo_obj.present?
      @account.klaviyo_list.update(membership_list: membership, academy: purchased_academy)
      @account.update(is_subscribed_to_mailing: true)
      render json: {message: "Subscribed successfully!"}
    end

    def unsubscribe
      list_id = klaviyo_list_id
      response = @@klaviyo.unsubscribe(list_id, @account.email)
      @account.update(is_subscribed_to_mailing: false)

      klaviyo_obj = @account.klaviyo_list

      if klaviyo_obj.present?
        membership = klaviyo_obj.membership_list
        membership_list = 'skin_deep_app_free_users'
        case membership
        when 'free'
          membership_list = 'skin_deep_app_free_users'
        when 'glow_getter'
          membership_list = 'skin_deep_app_glow_getter_users'
        when 'elite'
          membership_list = 'skin_deep_app_elite_users'
        end
        membership_list_id = klaviyo_list_id(membership_list)
        response = @@klaviyo.unsubscribe(membership_list_id, @account.email)

        subscribed_to_academy_list = klaviyo_obj.academy
        if subscribed_to_academy_list
          academy_list_id = klaviyo_list_id('skin_deep_app_academy_users')
          response = @@klaviyo.unsubscribe(academy_list_id, @account.email)
        end
        @account.klaviyo_list.update(membership_list: "unsubscribed", academy: false)
      end

      render json: {message: "Unsubscribed successfully!"}
    end

    def freeze_account
      @account.update(freeze_account: true)
      AccountMailer.with(account: @account).freeze_account.deliver
      payload_data = {account: @account, notification_key: 'account_settings', inapp: true, push_notification: true, all: false, type: 'account_settings', notification_for: 'account_settings', key: 'profile'}
      BxBlockPushNotifications::FcmSendNotification.new("You have successfully frozen your account. ", "Account Frozen!", @account&.device_token, payload_data).call
      render json: {message: "Account frozen successfully."}
    end

    def unfreeze_account
      @account.update(freeze_account: false)
      render json: {message: "Account unfrozen successfully."}
    end

    def skin_journey
      @skin_journey = @account.skin_journeys.find_by(id: params[:skin_journey_id])
      render json: SkinJourneySerializer.new(@skin_journey).serializable_hash
    end

    def add_sign_in_time
      @account.active_hours.where(to: nil).update(to: Time.now)
      @account.active_hours.create(from: Time.now)
      render json: {message: "Sign in added."}
    end

    def add_sign_out_time
      last_sign_in = @account.active_hours.where(to: nil).last
      last_sign_in.update(to: Time.now) if last_sign_in.present?
      render json: {message: "Sign out added."}
    end 
    
    private

    def klaviyo_list_id(list_name="skin_deep_app")
      
      klaviyo_list = JSON.parse(@@klaviyo.get_list)
      list_id = ""
      klaviyo_list.each do |item|
        if item["list_name"] == list_name
          list_id = item["list_id"]
        end
      end
      if list_id == ""
        list_id = JSON.parse(@@klaviyo.create_list(list_name))["list_id"]
      end
      list_id
    end

    def set_account
      @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
      @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
      @account
    end

    def update_account_params
      params[:account][:addresses_attributes]&.each do |address|
        address_params = params[:account][:addresses_attributes].first
        address_params.merge!(address_type: 'Home') if !address_params[:address_type].present?
      end
      params.require(:account).permit(:first_name, :last_name, :full_phone_number, :gender, :email, :profile_pic, :age, :password, :location, :blocked, addresses_attributes: [:id, :country, :city, :street, :county, :postcode, :longitude, :latitude, :address_type, :_destroy])
    end

    def check_valid_user
      account_id = params[:id] || params[:account_id]
      account = AccountBlock::Account.find(account_id) unless @token.account_type == "AdminAccount"
      account = AdminUser.find(account_id) if @token.account_type == "AdminAccount"
      render json: {errors: ['details does not belongs to this user']}  unless account == @account
    end

    def update_jwt_token(account, account_type="EmailAccount")
      jwt_token = SecureRandom.hex(4)
      account.update(jwt_token: jwt_token)
      BuilderJsonWebToken.encode(account.id, {jwt_token: jwt_token, account_type: account_type}, 1.year.from_now)
    end
  end
end
