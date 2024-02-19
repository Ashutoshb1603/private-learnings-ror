require 'redis'
module BxBlockContentmanagement
    class SendMailsWorker
        include Sidekiq::Worker
        def perform(title)
            redis = Redis.new(host: 'localhost')
            emails = JSON.parse(redis.get("emails"))
            emails_ids = emails.each_slice(70).to_a
            emails_ids.length.times do |loop_count|
                begin
                    emails = emails - emails_ids[loop_count]
                    redis.set("emails", emails)
                    AcademiesMailer.with(course_title: title, emails: emails_ids[loop_count]).academy_course_added.deliver
                    puts "Remaining mails are #{redis.get("emails")}"
                rescue EOFError, IOError, TimeoutError, Errno::ECONNRESET, Errno::ECONNABORTED, Errno::EPIPE, Errno::ETIMEDOUT, Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError, OpenSSL::SSL::SSLError => e
                    puts "Could not send email to #{emails_ids[loop_count]} because #{e}"
                end
            end
        end
    end
end
