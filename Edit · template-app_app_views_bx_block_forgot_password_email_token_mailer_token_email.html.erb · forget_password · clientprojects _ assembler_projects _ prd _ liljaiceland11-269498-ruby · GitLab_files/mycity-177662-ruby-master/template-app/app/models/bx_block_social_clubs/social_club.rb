module BxBlockSocialClubs
	class SocialClub < BxBlockSocialClubs::ApplicationRecord
	  self.table_name = :social_clubs
	  include DocumentSearch
	  include GenerateCoordinate

	  has_many_attached :images

	  before_validation :set_fee_currency, :set_language

	  validates :description, :interest_ids, :community_rules, :location, :name,
	  			:images, presence: true

	  validates :fee_amount_cents, :user_capacity, :bank_name, :bank_account_name, :bank_account_number,
				:routing_code, presence: true, if: Proc.new	{ |social_club| social_club.is_visible == false }

	  has_many :club_events, class_name: "BxBlockClubEvents::ClubEvent", dependent: :destroy

	  has_and_belongs_to_many :interests, class_name: "BxBlockInterests::Interest", dependent: :destroy

	  has_many :account_social_clubs, class_name: "BxBlockSocialClubs::AccountSocialClub", dependent: :destroy
	  has_many :accounts, through: :account_social_clubs, class_name: "AccountBlock::Account"

	  has_one :chat, class_name: "BxBlockChat::Chat", dependent: :destroy

	  enum status: %i(draft approved archieved deleted)
	  enum language: %i(english arabic)
	  belongs_to :account, class_name: "AccountBlock::Account"

	  after_save :send_email_notification
	  after_create :change_user_type, :send_notification_to_admin
	  before_save :parse_coordinates

	  def set_language
			self.language = 0 if language.nil?
	  end

	  def change_user_type
			account.update!(user_type: 'NP_Social_Club_Admin')
	  end

	  def set_fee_currency
			self.fee_currency = fee_currency.present? ? fee_currency : account.currency
	  end

	  def is_club_admin?(user_id)
	  	account_id == user_id.to_i
	  end

	  def send_email_notification
			if self.status_changed?
				if status == "approved"
					BxBlockSocialClubs::SocialClubMailer.social_club_email(account).deliver_later
				end
			end		
	  end

		def send_notification_to_admin
			if account_id.present?
				image = self.images&.first&.service_url rescue nil
				BxBlockEmailnotifications::UserNotificationMailer.new_social_club(name, image).deliver_later
			end
		end

    def interest_names_en
      interests.map(&:name).join(',')
    end

    def interest_names_ar
      interests.map(&:name_ar).join(',')
    end
  
    multisearchable(against: [:name, :location, :description, :interest_names_en, :interest_names_ar],
      additional_attributes: -> (club) { { name: club&.name, latitude: club&.latitude, longitude: club&.longitude, location: club&.location, language: club&.language, status: club.status, city: club.city, club_type: club.is_visible ? 'public' : 'private' } })

    pg_search_scope :search_by_words, against: [:name, :description, :location], 
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