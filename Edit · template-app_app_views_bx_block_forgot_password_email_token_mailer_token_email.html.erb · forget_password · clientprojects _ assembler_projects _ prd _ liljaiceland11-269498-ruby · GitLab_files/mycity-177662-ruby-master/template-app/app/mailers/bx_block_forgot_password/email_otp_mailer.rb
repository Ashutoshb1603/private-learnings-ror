module BxBlockForgotPassword
  class EmailOtpMailer < ApplicationMailer
    def email_otp
      otp_details = params[:otp]
        @account = params[:account]
      @otp = otp_details.pin
        @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
      mail(
        to: @account.email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Reset Password Verification OTP') do |format|
      format.html { render 'email_otp' }
      end
    end    
  end
end
