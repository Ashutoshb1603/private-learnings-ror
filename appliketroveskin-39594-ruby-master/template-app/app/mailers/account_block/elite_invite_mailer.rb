module AccountBlock
    class EliteInviteMailer < ApplicationMailer
      
        def invitation_email
            @email = params[:email]
            @account = AccountBlock::EmailAccount.where('LOWER(email) = ?', @email).first
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @plan_type = params[:plan_type]

            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: "SKIN DEEP: You have been invited to become#{@plan_type == "elite" ? "Elite ": ""} GlowGetter member") do |format|
                    format.html { render 'invitation_email' }
                end
        end

        def upgrade_email
            @email = params[:email]
            @account = AccountBlock::EmailAccount.where('LOWER(email) = ?', @email).first
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @plan_type = params[:plan_type]

            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: "SKIN DEEP: You are now #{@plan_type == "elite" ? "an Elite ": "a "}GlowGetter.") do |format|
                    format.html { render 'upgrade_email' }
                end
        end

        def downgrade_email
            @email = params[:email]
            @account = AccountBlock::EmailAccount.where('LOWER(email) = ?', @email).first
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]

            mail(
                to: @email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: "SKIN DEEP: You no longer meet the criteria of Elite Glowgetter status.") do |format|
                    format.html { render 'downgrade_email' }
                end
        end
    end
end
  