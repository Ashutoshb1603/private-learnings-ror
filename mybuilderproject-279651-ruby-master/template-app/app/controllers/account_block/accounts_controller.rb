module AccountBlock
  class AccountsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, only: :search

    def create
      account_params=account_param

      query_email = account_params['email'].downcase
      account = Account.where('LOWER(email) = ?', query_email).first

      # query_phone_number=account_params['full_phone_number']
      # account1=Account.where('full_phone_number=?', query_phone_number).first

      validator = EmailValidation.new(email_otp_params)
      return render json: {errors: [
        {account: 'Email invalid'},
      ]}, status: :unprocessable_entity if !validator.valid?

      if account.present? && account1.present? && account.activated == true
        render json: {message: " Your account is already created, Please login."}
      elsif account.present? && account.activated?
        render json: {message: " Email id already exists, Please try to sign up using different email id."}
      elsif account1.present? && account1.activated == true
        render json: {message: " Phone number already exists, Please try to sign up using different phone number."}
      else
        @account = Account.new(account_params)
        @account.platform = request.headers['platform'].downcase if request.headers.include?('platform')
        @account.user_type = account_params['user_type'] 
        if @account.save  
          @table = AccountBlock::OtpTable.new(user_type: params[:data][:attributes][:user_type],full_phone_number: params[:data][:attributes][:full_phone_number],email: params[:data][:attributes][:email])

          @table.save
          
          AccountBlock::EmailOtpMailer.with(account: @account, otp: @table.pin, host: request.base_url).email_otp.deliver_now  
          
          render json: OtpTableSerializer.new(@table, meta: {message: "Otp sent to phone number and email successfully.", token: encode(@table.id)}).serializable_hash, status: :created
        else
          render json:{errors: [@account.errors]}, status: :unprocessable_entity
        end
      end
    end
    
    def get_country_list
      data = []
      Country.all.each do |object|
        data << {country_name: object.name, country_ISO_code: object.alpha2, country_code: object.country_code, country_flag: object.emoji_flag}
      end
      render json: data, status: :ok
    end


    private
    def email_otp_params
      email = {:email =>jsonapi_deserialize(params)["email"]}
    end

    def encode(id)
      BuilderJsonWebToken.encode id
    end

    def account_param
      params.require(:data)[:attributes].permit(:user_type,:first_name, :last_name, :operator_address, :email, :country_code, :phone_number, :full_phone_number)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end
  end
end

