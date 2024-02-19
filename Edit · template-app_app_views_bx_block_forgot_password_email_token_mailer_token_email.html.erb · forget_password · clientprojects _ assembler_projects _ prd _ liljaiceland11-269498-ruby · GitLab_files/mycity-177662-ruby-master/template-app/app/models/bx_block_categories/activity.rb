module BxBlockCategories
	class Activity < ApplicationRecord
		self.table_name = :activities
		
		belongs_to :account, class_name: 'AccountBlock::Account', optional: true
		# has_many :hidden_place_activities, class_name: "BxBlockCategories::HiddenPlaceActivity", dependent: :destroy
		# has_many :hidden_places, through: :hidden_place_activities
		has_and_belongs_to_many :club_events, class_name: "BxBlockClubEvents::ClubEvent"
		after_save :send_notification_to_user
		after_create :send_notification_to_admin

		validates :name, presence: true
		
		enum status: %i(draft approved archieved deleted)

		private

		def send_notification_to_user
			if saved_change_to_name?
				BxBlockEmailnotifications::AdminNotificationMailer.activity_change(saved_change_to_name.reject(&:blank?).first, account.email).deliver_later if account.present?
			end
		end

		def send_notification_to_admin
			if account_id.present?
				BxBlockEmailnotifications::UserNotificationMailer.new_activity_added(name || name_ar).deliver_later
			end
		end
	end
end
