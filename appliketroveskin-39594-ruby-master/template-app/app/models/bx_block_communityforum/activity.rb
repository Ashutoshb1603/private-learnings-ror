module BxBlockCommunityforum
  class Activity < ApplicationRecord
    self.table_name = :activities

    # belongs_to :accountable, class_name: 'AccountBlock::Account'
    belongs_to :accountable, polymorphic: true
    belongs_to :objectable, polymorphic: true
    belongs_to :user_activity, class_name: 'AccountBlock::Account', foreign_key: :concern_mail_id, optional: true

    enum action: {'liked': 1, 'commented': 2, 'mentioned': 3, 'replied': 4}

    # after_create :send_notification

    def send_notification
      fcm = FCM.new(ENV["FIREBASE_SERVER_KEY"])
      registration_ids = [user_activity&.device_token]
      title = "#{action.camelcase} notification"
      objectable_text = objectable_type.eql?("BxBlockCommunityforum::Comment") &&  objectable.objectable.present? && objectable.objectable_type.eql?("BxBlockCommunityforum::Question") ? "question" : objectable_type&.split("::")&.last&.downcase
      text = ""
      if liked?
        text = "your #{objectable_text}"
      elsif commented? || replied?
        text = "on your #{objectable_text}"
      else
        text = "you in a comment"
      end
      body = "Hello #{user_activity&.name}, #{accountable&.name} has #{action} #{text}."
      options = { "notification":
                  {
                    "title": title,
                    "body": body
                  }
                }
      response = fcm.send(registration_ids, options) if registration_ids.compact.present?
      user_activity.notifications.create(headings: title, contents: body, type_by_user: 'skin_hub')
    end
  end
end
