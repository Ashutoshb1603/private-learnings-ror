module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ActiveStorage::SetCurrent

    before_action :validate_json_web_token, only: [:search, :update, :confirm_otp_and_update_email, :confirm_otp_email_of_current_user, :send_otp_to_update_profile,:send_otp_to_current_user, :update_interests, :get_profile, :remove_interests, :resend_otp_to_current_email, :add_user_location, :get_user_location]
    before_action :current_user, only: [:update ,:confirm_otp_email_of_current_user, :send_otp_to_current_user, :send_otp_to_update_profile, :confirm_otp_and_update_email, :update_interests, :get_profile, :remove_interests, :resend_otp_to_current_email, :add_user_location, :get_user_location]
    before_action :validate_activated_user, only: [:update, :get_profile]

    before_action :resize_image, only: [:create,:update]

    def create
      return render json: {status: 400, message: 'Email/Phone number is mandatory'} if account_params[:email].blank? && account_params[:phone_number].blank?

      object_key = ["email", 'full_name', 'user_name'] 
      object_key.each do|data|
        return render json: { status: 401, message: data.titleize + " Should not be blank", data: []} if account_params[data].blank?
      end

      @account = AccountBlock::Account.where('LOWER(email) = ?', account_params[:email].downcase).first
      return render json: {status: 400, message: 'Account already exist'} if @account.present? && @account.activated?

      email_validation = AccountBlock::EmailValidation.new(account_params[:email])
      unless email_validation.valid?
        return render json: { message: email_validation.errors.full_messages.first, status: 400}
      end

      if @account.blank?
        @account = AccountBlock::Account.new(account_params)
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')
        @account.preferred_language = account_params[:language].blank? ? 'english' : account_params[:language]
        @account.password = SecureRandom.hex

        if @account.save
          send_email_otp(@account.email)
        else
          render json: {errors: format_activerecord_errors(@account.errors)},
              status: :unprocessable_entity
        end
      else
        send_email_otp(@account.email)
      end
    end

    def currency_codes
      currencies = ["SAR", "USD", "EUR", "GBP", "AED", "JOD"]
      render json: { "currency list": currencies }, status: :ok
    end

    def update_interests
      account = @current_user
      if account
        if params[:interest_ids].present?
          params[:interest_ids].each do |interest_id|
            AccountBlock::AccountsInterest.find_or_create_by(account_id: @current_user.id, interest_id: interest_id)
          end
          render json: {
            message: "interests updated successfully..",
            token: BuilderJsonWebToken.encode(account.id,1.months.from_now),
            account: AccountSerializer.new(account)
          }
        else
          render json: {error: "Interests not present"},status: :unprocessable_entity
        end
      else
        render json: {error: "Account not present"},status: :unprocessable_entity
      end
    end

    def remove_interests
      account = @current_user
      if account
        if params[:interest_ids].present?
          params[:interest_ids].each do |interest_id|
            interests_counts = AccountBlock::AccountsInterest.where(account_id: @current_user.id).count
            if interests_counts > 1
              AccountBlock::AccountsInterest.find_by(account_id: @current_user.id, interest_id: interest_id)&.destroy
              render json: {
                message: "Interest Removed successfully..",
                # token: BuilderJsonWebToken.encode(account.id,1.months.from_now),
                account: AccountSerializer.new(account)
              }
            else 
              return render json: {
                message: "Can't Remove Atleast one Interest Require",
                account: AccountSerializer.new(account)
              },status: 403          
            end
          end
 
        else
          render json: {error: "Interests Not Present"},status: :unprocessable_entity
        end
      else
        render json: {error: "Account not present"},status: :unprocessable_entity
      end
    end

    def search
      @accounts = Account.where(activated: true)
                    .where('first_name ILIKE :search OR '\
                           'last_name ILIKE :search OR '\
                           'email ILIKE :search', search: "%#{search_params[:query]}%")
      if @accounts.present?
        render json: AccountSerializer.new(@accounts, meta: {message: 'List of users.'
        }).serializable_hash, status: :ok
      else
        render json: {errors: [{message: 'Not found any user.'}]}, status: :ok
      end
    end

    def update
      get_email = account_params[:email].present? && account_params[:email] != @current_user.email

      if get_email.present?
        @current_user.update(edit_params)
        send_otp_to_current_user  
      else
        if @current_user.update(edit_params)            
          render json:  AccountSerializer.new(@current_user, meta: {message: 'Profile Updtaed successfully!'
          }).serializable_hash, status: :ok
        else
          render json: {errors: @current_user.errors}, status: :unprocessable_entity
        end
      end              
    end

    def resend_otp_to_new_email
      send_otp_to_update_profile          
    end

    def resend_otp_to_current_email
      send_otp_to_current_user          
    end

    def get_profile  
      account = @current_user
      if account.present?
        render json: {
          message: "Profile fetched successfully..",
          # token: BuilderJsonWebToken.encode(account.id,1.months.from_now),
          account: AccountSerializer.new(account)
        }
      else
        render json: {error: "Account not found"},status: :unprocessable_entity
      end
    end

    def confirm_otp_email_of_current_user
      email_otp=EmailOtp.find_by_pin(params[:otp])
      if email_otp.present?
        send_otp_to_update_profile   
      else
        render json: {meta: {message: :'OTP Invalid!'}}, status: :unprocessable_entity
      end     

    end

    def confirm_otp_and_update_email
      email_otp = EmailOtp.find_by_pin(params[:otp])   
      if email_otp.present?
        @current_user.update(email: email_otp.email)
        render json: AccountSerializer.new(@current_user, meta: {message: 'OTP Validation successful!'}).serializable_hash, status: :ok
      else
        render json: {meta: {message: :'OTP Invalid!'}}, status: :unprocessable_entity
      end
    end

    def add_user_location
      if @current_user.update(add_location_params)
        render json: {message: "Updated successfully."}, status: :ok
      else
        render json: {errors: @current_user.errors}, status: :unprocessable_entity
      end
    end

    def get_user_location
      if @current_user
        render json: {
          id: @current_user.id,
          name: @current_user.full_name,
          latitude: @current_user.latitude,
          longitude: @current_user.longitude,
          current_city: @current_user.current_city
        }, status: :ok
      else
        render json: {errors: @current_user.errors}, status: :unprocessable_entity
      end
    end

    private

    def send_otp_to_current_user
      email_otp = AccountBlock::EmailOtp.create(:email => @current_user.email) 
      if send_update_email_for email_otp,@current_user,@current_user.email
        render json:  AccountSerializer.new(@current_user, meta: {message: " OTP sent on #{@current_user.email}"
        }).serializable_hash, status: :ok
      end
    end

    def send_otp_to_update_profile  
      email_otp = AccountBlock::EmailOtp.create(update_email_params) 
      if send_update_email_for email_otp,@current_user,update_email_params[:email]
        render json:  AccountSerializer.new(@current_user, meta: {message: "OTP sent successfully on #{update_email_params[:email]}"
        }).serializable_hash, status: :ok
      end
    end

    def current_user
      begin
        @current_user = AccountBlock::Account.find(@token.id)
      rescue ActiveRecord::RecordNotFound => e
        return render json: {errors: [
            {message: 'Please login again.'},
        ]}, status: :unprocessable_entity
      end
    end

    def validate_activated_user
      if @token.token_type == 'signup' || (@current_user.present? && !@current_user.activated)
        return render json: {status: 401, error: 'Your Account is not activated'}, status: 401
      end
    end

    def send_update_email_for(otp_record,account,email)
      EmailUpdateOtpMailer
        .with(account: account,otp: otp_record,email: email, host: request.base_url)
        .email_otp.deliver_now
    end

    def send_email_for(otp_record, account)      
      EmailOtpMailer
        .with(account: account,otp: otp_record, host: request.base_url)
        .email_otp.deliver_now
    end

    def send_email_otp(email)
      email_otp = AccountBlock::EmailOtp.new(email: email)
      if email_otp.save
        send_email_for(email_otp, @account)

        render json: AccountSerializer.new(@account, meta: {message: "Verification otp send to your email successfully",
          token: encode(@account.id),
        }).serializable_hash, status: :created
      else
        render json: {
          errors: [email_otp.errors],
        }, status: :unprocessable_entity
      end
    end

    def email_otp_params
      email = {:email => jsonapi_deserialize(params)["email"]}
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def encode(id)
      BuilderJsonWebToken.encode(id, 10.minutes.from_now, token_type: 'signup')
    end

    def edit_params
      params.require(:data)[:attributes].permit(:phone_number, :country_code, :user_name, :full_name, :image, :currency, :language, :term_and_condition, :age_confirmation, :service_and_policy)
    end

    def search_params
      params.permit(:query)
    end

    def update_email_params
      params.require(:data)[:attributes].permit(:email)
    end

    def add_location_params
      params.permit(:current_city, :latitude, :longitude)
    end

    def account_params
      params.require(:data)[:attributes].permit(:full_name, :user_name, :phone_number, :country_code, :email, :term_and_condition, :age_confirmation, :service_and_policy, :language, :image)
    end

    def resize_image
      if account_params[:image].present?
        content_type = account_params[:image].content_type 
        path = account_params[:image].tempfile.path
        image = MiniMagick::Image.open(path.to_s)
        image.resize "320x194"    
        if ["image/jpg","image/png","image/jpeg"].include?(content_type)
          if params[:action] == "create"
            account_params[:image].tempfile = image.tempfile
          elsif params[:action] == "update" 
            edit_params[:image].tempfile = image.tempfile
          end
        end
      end
    end

  end
end
