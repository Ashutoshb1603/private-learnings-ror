module BxBlockEventregistration
  class UniqueCodeMailer < ApplicationMailer
    def email_unique_code
      @account = params[:account]
      @otp = params[:otp]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
      mail(
        to: @account.email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Unique code for event') do |format|
        format.html { render '/account_block/unique_code_mailer/unique_code' }
      end
    end    
  end
end
