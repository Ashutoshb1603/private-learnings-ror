module AccountBlock
    class AccountMailer < ApplicationMailer

        def user_onboarding
            @account = params[:account]
            @host = base_url
            @password = params[:password]
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Glowgetter early access to Skin Deep by Corinna Tolan!') do |format|
              format.html { render 'user_onboarding' }
            end
        end

        def delete_account
            @account = params[:account]
            @host = base_url
            @datetime = DateTime.now
           
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Skin Deep account deleted') do |format|
              format.html { render 'delete_account' }
            end
        end

        def delete_confirmation
            @account = params[:account]
            @host = base_url
            @url = @host + "/account_block/accounts/account_delete/#{@account.id.to_s}?token=#{params[:token]}"
           
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Skin Deep - Account deletion request') do |format|
              format.html { render 'delete_confirmation' }
            end
        end

        def freeze_account
            @account = params[:account]
            @host = base_url
            @datetime = DateTime.now
           
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Skin Deep account frozen') do |format|
              format.html { render 'frozen_account' }
            end
        end

        def contact_us
            @account = params[:account]
            @params = params[:params]
            @host = base_url
            @subject = 'App Contact Form: ' + @params[:subject].to_s
            @image1 = base_url + Rails.application.routes.url_helpers.rails_blob_url(@account.contact_us_primary_image, only_path: true) if params[:primary_image].present?
            @image2 = base_url + Rails.application.routes.url_helpers.rails_blob_url(@account.contact_us_secondary_image, only_path: true) if params[:secondary_image].present?
            mail(
                to: ENV['SMTP_USERNAME'],
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: @subject) do |format|
              format.html { render 'contact_us' }
            end
        end

        def block_email
          @account = params[:account]
          @host = base_url

          mail(
              to: @account.email,
              from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
              subject: "You have been muted in our forums.") do |format|
                format.html { render 'block_email' }
          end
        end

        private
        def base_url
          Rails.env.production? ? ENV['BASE_URL'] : 'http://localhost:3000'
        end
    end
end
