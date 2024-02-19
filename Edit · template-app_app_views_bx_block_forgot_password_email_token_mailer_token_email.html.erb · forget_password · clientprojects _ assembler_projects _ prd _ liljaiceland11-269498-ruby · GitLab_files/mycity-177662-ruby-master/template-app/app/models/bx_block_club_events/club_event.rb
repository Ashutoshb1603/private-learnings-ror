module BxBlockClubEvents
  class ClubEvent < BxBlockClubEvents::ApplicationRecord
    self.table_name = :club_events
    include DocumentSearch
    include GenerateCoordinate
    
    has_many_attached :images

    validates :event_name, :location, :start_date_and_time, :end_date_and_time, :max_participants,
              :description, :fee_amount_cents, :images, presence: true

    validates :fee_currency, :fee_amount_cents, presence: true,
              if: Proc.new { |club_event| club_event.is_visible == false }

    validates :start_time, :end_time, presence: true, on: :create            
        
    enum status: %i(draft approved archieved deleted)

    has_and_belongs_to_many :activities, class_name: "BxBlockCategories::Activity", dependent: :destroy
    # has_and_belongs_to_many :equipments, class_name: "BxBlockEquipments::Equipment"
    has_many :event_travel_items, class_name: "BxBlockClubEvents::EventTravelItem", dependent: :destroy
    has_many :travel_items, through: :event_travel_items, class_name: "BxBlockCategories::TravelItem"
    
    has_many :club_event_accounts, class_name: "BxBlockEventregistration::ClubEventAccount", dependent: :destroy
    has_many :accounts, through: :club_event_accounts, class_name: "AccountBlock::Account"

    attr_accessor :start_time, :end_time

    belongs_to :social_club, class_name: "BxBlockSocialClubs::SocialClub"

    before_validation :set_date_time, :set_fee_currency, :set_social_club

    after_save :send_email_notification, :send_notification_to_admin
    after_create :notify_social_club_users
    before_save :parse_coordinates

		geocoded_by :address

		def address 
            [latitude, longitude].compact.join(", ") 
        end

        def set_social_club
            self.social_club_id = social_club.id
        end

        def set_date_time
            return if (start_date_and_time.nil? || start_time&.strip.nil?)
            return if (end_date_and_time.nil? || end_time&.strip.nil?)
            return unless (start_date_and_time_changed? || end_date_and_time_changed?) && new_record?
                        
            self.start_date_and_time = start_date_and_time.to_date + parse_time(start_time)
            self.end_date_and_time = end_date_and_time.to_date + parse_time(end_time)
        end

        def set_fee_currency
            self.fee_currency = social_club.fee_currency
        end

        def parse_time(time)         
            Time.zone.parse(time).seconds_since_midnight.seconds
        end

        def send_email_notification                        
            BxBlockClubEvents::ClubEventMailer.club_event_email(social_club.account).deliver_later if status == "approved"
        end

        def send_notification_to_admin
          if self.social_club.account_id.present?
            image = self.images&.first&.service_url rescue nil
            BxBlockEmailnotifications::UserNotificationMailer.new_club_event(event_name, image).deliver_later
          end
		    end

        def notify_social_club_users
          accounts = get_social_club_accounts
          image = self.images&.first&.service_url rescue nil
          accounts.each do |account_object|
            BxBlockPushNotifications::PushNotification.create(
              push_notificable: account_object,
              remarks: "Club Event Created",
              content: "#{self.social_club&.name} added new event: *#{self.event_name}*",
              image: image,
              notify_type: 'club_event'
            )
          end
        end

        def get_social_club_accounts
          account_ids = self.social_club&.account_social_clubs&.pluck(:account_id)&.uniq
          AccountBlock::Account.where(id: account_ids)
        end

        def activitiy_names
          activities.map(&:name).join(',')
        end

        def travel_items_names
          travel_items.map(&:name).join(',')
        end

        multisearchable(against: [:event_name, :location, :description, :activitiy_names, :travel_items_names],
            additional_attributes: -> (event) { { name: event&.event_name, latitude: event&.latitude, longitude: event&.longitude, location: event&.location, status: event.social_club.status, city: event.city } }
        )

        pg_search_scope :search_by_words, against: [:event_name, :description, :location], 
                    using: {
                      tsearch: { prefix: true }
                    }

        def update_search_document
          self.update_pg_search_document
        end

        def delete_search_document
          self.update_pg_search_document
        end

        def parse_coordinates
          if location.present? && location_changed?
            generate_coordinates(location)  
          end
          self
        end
    end
end
