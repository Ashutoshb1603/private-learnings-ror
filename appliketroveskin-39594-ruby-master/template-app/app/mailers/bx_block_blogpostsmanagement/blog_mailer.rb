module BxBlockBlogpostsmanagement
    class BlogMailer < ApplicationMailer
        def blog_created
            @article = params[:article]
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @datetime = DateTime.now
            @emails = params[:emails]
            @emails.each do |email|
                mail(
                    to: email,
                    from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                    subject: 'Corinna has just posted her latest blog on Skin Deep') do |format|
                format.html { render 'blog_created' }
                end
            end
        end
    end
end
