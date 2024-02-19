module AccountBlock
    class TherapistPasswordMailer < ApplicationMailer
      def password_email
        @account = params[:account]
        @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
  
        @password = params[:password]
        mail(
            to: @account.email,
            from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
            subject: 'Therapist early access to Skin Deep by Corinna Tolan!') do |format|
          format.html { render 'password_email' }
        end
      end
  
    end
  end
  