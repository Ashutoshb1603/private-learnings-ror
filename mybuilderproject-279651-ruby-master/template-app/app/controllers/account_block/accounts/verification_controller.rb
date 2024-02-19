# frozen_string_literal: true

module AccountBlock
  module Accounts
    class VerificationController < ApplicationController
      include BuilderJsonWebToken::JsonWebTokenValidation

      before_action :validate_json_web_token
      def create
        begin
          @otp = OtpTable.find(@token.id)

        rescue ActiveRecord::RecordNotFound => e
          return render json: {errors: [
            {account: 'Account Not Found'},
          ]}, status: :unprocessable_entity
        end

        if @otp.valid_until < Time.current
          @otp.destroy

          return render json: { errors: [
            { pin: 'This Pin has expired, please request a new pin code.' }
          ] }, status: :unauthorized
        end
        

        @account = AccountBlock::Account.find_by(email: @otp.email)
        if @otp.activated?
          return render json: ValidateAvailableSerializer.new(@otp, meta: {
            message: 'Account Already Activated',
          }).serializable_hash, status: :ok
        end

        if @otp.pin.to_s == params['pin'].to_s
          @otp.activated = true
          @otp.save
          @account.update!(activated: true)
          # @account.save
          render json: ValidateAvailableSerializer.new(@otp, meta: {
            message: "Email and phone number Confirmed Successfully",
            token: BuilderJsonWebToken.encode(@otp.id)
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