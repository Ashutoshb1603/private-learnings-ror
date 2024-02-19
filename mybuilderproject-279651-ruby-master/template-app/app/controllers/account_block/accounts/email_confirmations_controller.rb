# frozen_string_literal: true

module AccountBlock
  module Accounts
    class EmailConfirmationsController < ApplicationController
      include BuilderJsonWebToken::JsonWebTokenValidation

      before_action :validate_json_web_token
      def create
        begin
          @email_otp = EmailOtp.find(@token.id)
        rescue ActiveRecord::RecordNotFound => e
          return render json: {errors: [
            {account: 'Account Not Found'},
          ]}, status: :unprocessable_entity
        end

        if @email_otp.valid_until < Time.current
          @email_otp.destroy

          return render json: { errors: [
            { pin: 'This Pin has expired, please request a new pin code.' }
          ] }, status: :unauthorized
        end

        @account = AccountBlock::Account.find_by(email: @email_otp.email)
        if @email_otp.activated?
          return render json: ValidateAvailableSerializer.new(@email_otp, meta: {
            message: 'Account Already Activated',
          }).serializable_hash, status: :ok
        end

        if @email_otp.pin.to_s == params['pin'].to_s
          @email_otp.activated = true
          @email_otp.save
          @account.update!(activated: true)
          # @account.save
          render json: ValidateAvailableSerializer.new(@email_otp, meta: {
            message: "Email Confirmed Successfully",
            token: BuilderJsonWebToken.encode(@email_otp.id)
          }).serializable_hash, status: :ok
        else
          render json: { errors: [
            { pin: 'Invalid OTP for email' }
          ] }, status: :unprocessable_entity
        end
      end
    end
  end
end