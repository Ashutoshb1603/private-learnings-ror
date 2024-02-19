module BxBlockCommunityforum
    class PostMailer < ApplicationMailer
        def offensive_post
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @post = params[:post]
        
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Your post has not been approved') do |format|
            format.html { render 'offensive_post' }
            end
        end
    end
end