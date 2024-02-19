module BxBlockCategories
	class Weather < ApplicationRecord
		self.table_name = :weathers

		belongs_to :account, class_name: 'AccountBlock::Account', optional: true
		after_save :send_notification_to_user
		after_create :send_notification_to_admin
		# has_many :hidden_place_weathers, class_name: "BxBlockCategories::HiddenPlaceWeather",dependent: :destroy
		# has_many :hidden_places, through: :hidden_place_weathers
		# validates :name, presence: true

		private

    def send_notification_to_user
      if saved_change_to_name?
        BxBlockEmailnotifications::AdminNotificationMailer.weather_change(saved_change_to_name.reject(&:blank?).first, account.email).deliver_later if account.present?
      end
    end

    def send_notification_to_admin
      if account_id.present?
        BxBlockEmailnotifications::UserNotificationMailer.new_weather_added(name || name_ar).deliver_later
      end
    end
		
	end
end
