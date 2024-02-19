 module BxBlockClubEvents
    class ClubEventMailer < ApplicationMailer
        def club_event_email(user)
            mail(to: user.email,
                from: 'builder.bx_dev@engineer.ai',
                subject: 'Event create Confirmation') do |format|
                    format.html { render 'club_event_email' }
                end
        end
    end
end