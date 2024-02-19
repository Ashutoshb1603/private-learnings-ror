module AccountBlock
  class Account < AccountBlock::ApplicationRecord
    ActiveSupport.run_load_hooks(:account, self)
    self.table_name = :accounts

    include Wisper::Publisher

    has_secure_password
    # before_validation :parse_full_phone_number
    # validates :full_phone_number, uniqueness: true
    # before_validation :valid_phone_number
    validates :full_name, :user_name, presence: true
    before_create :generate_api_key
    has_one :blacklist_user, class_name: 'AccountBlock::BlackListUser', dependent: :destroy
    after_save :set_black_listed_user
    
    enum status: %i[regular suspended deleted]
    enum language: {'english': 'English', 'arabic': 'Arabic'}

    has_many :accounts_interests,class_name: "AccountBlock::AccountsInterest"
    has_many :interests, through: :accounts_interests, class_name: "BxBlockInterests::Interest"
    has_many :hidden_places, class_name: "BxBlockHiddenPlaces::HiddenPlace", dependent: :destroy
    has_many :social_clubs, class_name: "BxBlockSocialClubs::SocialClub"

    has_many :account_social_clubs, class_name: "BxBlockSocialClubs::AccountSocialClub"
    has_many :joined_social_clubs, through: :account_social_clubs, source: :social_club

    has_many :account_event_blocks, class_name: "BxBlockEventregistration::AccountEventBlock"
    has_many :event_blocks, through: :account_event_blocks, class_name: "BxBlockEventregistration::EventBlock"

    has_many :club_event_accounts, class_name: "BxBlockEventregistration::ClubEventAccount"
    has_many :club_events, through: :club_event_accounts, class_name: "BxBlockClubEvents::ClubEvent"

    has_many :devices, class_name: 'AccountBlock::Device', dependent: :destroy
    has_many :push_notifications, foreign_key: :push_notificable_id, class_name: 'BxBlockPushNotifications::PushNotification', dependent: :destroy

    has_many :flagged_message_accounts, class_name: "BxBlockChat::FlaggedMessageAccount"
    has_many :flagged_messages, through: :flagged_message_accounts, class_name: "BxBlockChat::FlaggedMessage"

    before_save :set_currency

    scope :active, -> { where(activated: true) }
    scope :existing_accounts, -> { where(status: ['regular', 'suspended']) }
    serialize :interests, Array
    has_one_attached :image
    validates :image, file_content_type: { allow: ['image/jpeg','image/jpg', 'image/png'], message: "Image should be (jpeg|png|jpg) format only" }

    geocoded_by :address

		def address 
      [latitude, longitude].compact.join(", ") 
    end
    
    private

    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code      = phone.country_code
      self.phone_number      = phone.raw_national
    end

    def valid_phone_number
      unless Phonelib.valid?(full_phone_number)
        errors.add(:full_phone_number, "Please enter valid Phone Number")
      end
    end

    def set_currency      
      self.currency = 'USD' if currency.nil?
    end

    def generate_api_key
      loop do
        @token = SecureRandom.base64.tr('+/=', 'Qrt')
        break @token unless Account.exists?(unique_auth_id: @token)
      end
      self.unique_auth_id = @token
    end

    def set_black_listed_user
      if is_blacklisted_previously_changed?
        if is_blacklisted
          AccountBlock::BlackListUser.create(account_id: id)
        else
          blacklist_user.destroy
        end
      end
    end

  end
end
