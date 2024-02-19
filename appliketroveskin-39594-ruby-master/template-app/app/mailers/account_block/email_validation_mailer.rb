module AccountBlock
  class EmailValidationMailer < ApplicationMailer
    def activation_email
      @account = params[:account]
      @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]

      @url = "#{@host}/account_block/accounts/email_confirmations/#{@account.id}?token=#{params[:token]}"

      mail(
          to: @account.email,
          from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
          subject: 'Welcome to Skin Deep by Corinna Tolan, please verify your email address') do |format|
        format.html { render 'activation_email' }
      end
    end

    private

    def encoded_token
      BuilderJsonWebToken.encode @account.id, 10.minutes.from_now
    end
  end
end
