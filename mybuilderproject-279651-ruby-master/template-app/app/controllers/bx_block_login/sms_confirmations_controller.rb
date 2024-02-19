# frozen_string_literal: true

module BxBlockLogin
  class SmsConfirmationsController < ApplicationController
      include BuilderJsonWebToken::JsonWebTokenValidation

      before_action :validate_json_web_token
      def create
        begin
          @sms_otp = AccountBlock::SmsOtp.find(@token.id)
        rescue ActiveRecord::RecordNotFound => e
          return render json: {errors: [
            {account: 'Account Not Found'},
          ]}, status: :unprocessable_entity
        end

        if @sms_otp.valid_until < Time.current
          @sms_otp.destroy

          return render json: { errors: [
            { pin: 'This Pin has expired, please request a new pin code.' }
          ] }, status: :unauthorized
        end

        if @sms_otp.pin.to_s == params['pin'].to_s
          @sms_otp.activated = true
          @sms_otp.save
          render json: AccountBlock::ValidateAvailableSerializer.new(@sms_otp, meta: {
            message: "Login Successfully",
            token: BuilderJsonWebToken.encode(@sms_otp.id)
          }).serializable_hash, status: :ok
        else
          render json: { errors: [
            { pin: 'Invalid OTP for email' }
          ] }, status: :unprocessable_entity
        end
      end
    end
end