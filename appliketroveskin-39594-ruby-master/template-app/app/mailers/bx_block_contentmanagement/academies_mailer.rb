module BxBlockContentmanagement
    class AcademiesMailer < ApplicationMailer
        def academy_course_added
            @course_title = params[:course_title]
            emails = params[:emails]
            @host = Rails.env.development? ? 'http://localhost:3000' : params[:host]
            mail(
                bcc: emails,
                from: "Skin Deep <#{ENV['SMTP_USERNAME']}>",
                subject: 'We have just issued a new masterclass in our training academy. Be one of the first to view by downloading here') do |format|
                format.html { render 'academy_course_added' }
            end
        end
    end
end

