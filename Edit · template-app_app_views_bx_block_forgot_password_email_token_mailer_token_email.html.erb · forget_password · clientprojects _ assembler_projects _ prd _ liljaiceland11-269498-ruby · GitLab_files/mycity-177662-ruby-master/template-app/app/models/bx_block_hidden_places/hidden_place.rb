module BxBlockHiddenPlaces
  class HiddenPlace < ApplicationRecord
    self.table_name = :hidden_places
    include DocumentSearch
    include GenerateCoordinate

    belongs_to :account, class_name: "AccountBlock::Account", optional: true
    has_many_attached :images
    has_and_belongs_to_many :activities, class_name: 'BxBlockCategories::Activity', dependent: :destroy
    has_and_belongs_to_many :travel_items, class_name: 'BxBlockCategories::TravelItem', dependent: :destroy
    has_and_belongs_to_many :weathers, class_name: 'BxBlockCategories::Weather', dependent: :destroy

    validates :place_name, :google_map_link, presence: true
    after_create :send_notification_to_admin
    before_save :parse_coordinates

    def activitiy_names
      activities.map(&:name).join(',')
    end

    def travel_items_names
      travel_items.map(&:name).join(',')
    end

    def weathers_names
      weathers.map(&:name).join(',')
    end

    def send_notification_to_admin
			if account_id.present?
        image = self.images&.first&.service_url rescue nil
				BxBlockEmailnotifications::UserNotificationMailer.new_hidden_place(place_name, image).deliver_later
			end
		end
  
    multisearchable(against: [:place_name, :description, :activitiy_names, :travel_items_names, :weathers_names],
      additional_attributes: -> (place) { { name: place&.place_name, latitude: place&.latitude, longitude: place&.longitude, location: place&.google_map_link, status: 'approved', city: place.city } })

    def update_search_document
      self.update_pg_search_document
    end

    def delete_search_document
      self.update_pg_search_document
    end

    def parse_coordinates
      if google_map_link.present? && google_map_link_changed?
        generate_coordinates(google_map_link)  
      end
      self
    end
    
  end
end
