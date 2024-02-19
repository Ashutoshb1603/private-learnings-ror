module BxBlockCategories
	class TravelItem < ApplicationRecord
		self.table_name = :travel_items
		
		belongs_to :account, class_name: 'AccountBlock::Account', optional: true
    has_many :event_travel_items, class_name: "BxBlockClubEvents::EventTravelItem"
    has_many :club_events, through: :event_travel_items, class_name: "BxBlockClubEvents::ClubEvent"

		after_save :send_notification_to_user
		after_create :send_notification_to_admin

		# has_many :hidden_place_travel_items, class_name: "BxBlockCategories::HiddenPlaceTravelItem",dependent: :destroy
		# has_many :hidden_places, through: :hidden_place_travel_items
		# validates :name, presence: true

		private

    def send_notification_to_user
      if saved_change_to_name?
        BxBlockEmailnotifications::AdminNotificationMailer.travel_item_change(saved_change_to_name.reject(&:blank?).first, account.email).deliver_later if account.present?
      end
    end

    def send_notification_to_admin
      if account_id.present?
        BxBlockEmailnotifications::UserNotificationMailer.new_travel_item_added(name || name_ar).deliver_later
      end
    end

	end
end
