module BxBlockForgotPassword
  class EmailOtpMailer < ApplicationMailer
    def otp_email
      @otp = params[:otp]
      @account = params[:account]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
      mail(
          to: @otp.email,
          from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
          subject: 'One time password code for Skin Deep by Corinna Tolan') do |format|
        format.html { render 'otp_email' }
      end
    end
  end
end
