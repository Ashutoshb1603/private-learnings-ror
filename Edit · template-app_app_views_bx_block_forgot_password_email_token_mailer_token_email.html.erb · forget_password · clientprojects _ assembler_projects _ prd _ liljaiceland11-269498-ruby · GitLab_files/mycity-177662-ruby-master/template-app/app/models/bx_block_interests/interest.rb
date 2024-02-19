module BxBlockInterests
	class Interest < ApplicationRecord
    self.table_name = :interests
    include ActiveStorageSupport::SupportForBase64
    
    has_one_attached :icon
    # validates :icon, presence: true

    has_many :accounts_interests,class_name: "AccountBlock::AccountsInterest",dependent: :destroy
    has_many :accounts, through: :accounts_interests
    belongs_to :created_user, class_name: 'AccountBlock::Account', optional: true, foreign_key: 'created_by'

    after_save :send_notification_to_user
    after_create :send_notification_to_admin

    private

    def send_notification_to_user
      if saved_change_to_name?
        if created_by.present?
          BxBlockEmailnotifications::AdminNotificationMailer.interest_change(saved_change_to_name.reject(&:blank?).first, created_user.email).deliver_later
        end
      end
    end

    def send_notification_to_admin
      if created_by.present?
        image = self.icon&.service_url rescue nil
        BxBlockEmailnotifications::UserNotificationMailer.new_interest_added(name, image).deliver_later
      end
    end
    
	end
end
