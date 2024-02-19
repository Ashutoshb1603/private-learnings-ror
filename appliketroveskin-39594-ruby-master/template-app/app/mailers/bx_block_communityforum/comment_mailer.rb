module BxBlockCommunityforum
    class CommentMailer < ApplicationMailer
        def offensive_comment
            @account = params[:account]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            @title = params[:title]
        
            mail(
                to: @account.email,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'Your comment has not been approved') do |format|
            format.html { render 'offensive_comment' }
            end
        end
    end
end