module BxBlockPayments
    class PlanMailer < ApplicationMailer
        def user_upgraded
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @datetime = DateTime.now
           
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'You are now a Glowgetter') do |format|
              format.html { render 'user_upgraded' }
            end
        end
    end
end
