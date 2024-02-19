module BxBlockSms
  module Providers
    class Twilio
      class << self
        def send_sms(full_phone_number, text_content)
          client = ::Twilio::REST::Client.new("AC498b8b89e6ec033874e4269b2391ae82", "9c036538c3e3053ccd6bfdf1b759dbb3")
          client.messages.create({
                                   from: +12762955226,
                                   to: full_phone_number,
                                   body: text_content
                                 })
        end

        # def account_id
        #   Rails.configuration.x.sms.account_id
        # end

        # def auth_token
        #   Rails.configuration.x.sms.auth_token
        # end

        def from
          Rails.configuration.x.sms.from
        end
      end
    end
  end
end
