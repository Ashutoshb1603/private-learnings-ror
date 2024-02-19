# frozen_string_literal: true

module AccountBlock
  module Accounts
    class SendOtpsController < ApplicationController
      # def create
      #   json_params = jsonapi_deserialize(params)
      #   account = SmsAccount.find_by(
      #     full_phone_number: json_params['full_phone_number'],
      #     activated: true)

      #   return render json: {errors: {message: 'Account already activated' }}, status: :unprocessable_entity unless account.nil?

      #   @sms_otp = SmsOtp.new(jsonapi_deserialize(params))
      #   if @sms_otp.save
      #     render json: SmsOtpSerializer.new(@sms_otp, meta: {
      #       token: BuilderJsonWebToken.encode(@sms_otp.id),
      #     }).serializable_hash, status: :created
      #   else
      #     render json: {errors: {message: @sms_otp.errors.full_messages}},
      #       status: :unprocessable_entity
      #   end
      # end
    end
  end
end
