module Notification
  class NotificationService
    FIREBASE_API_KEY = ENV["FIREBASE_SERVER_KEY"]

    def initialize(data)
      @fcm = FCM.new(FIREBASE_API_KEY)
      @data = data
    end

    def send_notfification
      user_token = @data[:tokens]
      data = {
          "notification": {
              "title": @data[:title],
              "body": @data[:body]
          }
      }
      response = @fcm.send(user_token, data)
    end

  end
end
