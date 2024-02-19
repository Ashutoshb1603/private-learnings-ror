module BxBlockPayments
    class WalletCreditMailer < ApplicationMailer
      
        def invitation_email
            @email = params[:email]
            @account = params[:account]
            @amount = params[:amount]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
    
            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Received Wallet Credit on SkinDeep App') do |format|
            format.html { render 'invitation_email' }
            end
        end

        def add_money
            @email = params[:email]
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
    
            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'You now have funds to your wallet') do |format|
            format.html { render 'add_money' }
            end
        end

        def topup_failed
            @email = params[:email]
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
    
            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Your attempt to lodge funds to your Skin Deep wallet has failed') do |format|
            format.html { render 'topup_failed' }
            end
        end
        
        def gift_received
            @email = params[:email]
            @account = AccountBlock::EmailAccount.where('LOWER(email) = ?', @email).first
            @sender = params[:sender]
            @amount = params[:amount]
            @custom_message = params[:message]
            @receiver = account = AccountBlock::EmailAccount.where('LOWER(email) = ?', @email).first
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
    
            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: "You have just received a glow gift, on Skin Deep!") do |format|
            format.html { render 'gift_received' }
            end
        end

        def send_gift
            @email = params[:email]
            @account = AccountBlock::EmailAccount.where('LOWER(email) = ?', @email).first
            @receiver = params[:receiver]
            @amount = params[:amount]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
    
            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'You have sent a glow gift') do |format|
            format.html { render 'gift_sent' }
            end
        end

    end
  end
  