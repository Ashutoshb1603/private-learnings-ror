module BxBlockSocialClubs
    class SocialClubMailer < ApplicationMailer
        def social_club_email(user)
            mail(to: user.email,
                from: 'builder.bx_dev@engineer.ai',
                subject: 'Social Club create Confirmation') do |format|
                    format.html { render 'social_club_email' }
                end
        end
    end
end
