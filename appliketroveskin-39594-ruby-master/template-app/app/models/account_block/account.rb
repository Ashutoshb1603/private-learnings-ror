module AccountBlock
  class Account < AccountBlock::ApplicationRecord
    belongs_to :role, class_name: 'BxBlockRolesPermissions::Role'
    has_many   :account_choice_skin_quizzes, class_name: 'BxBlockFacialtracking::AccountChoiceSkinQuiz', dependent: :destroy
    has_many :choices, through: :account_choice_skin_quizzes, class_name: 'BxBlockFacialtracking::Choice', dependent: :destroy
    has_many :tags, through: :choices, class_name: 'BxBlockCatalogue::Tag'
    has_many :addresses, as: :addressable, class_name: 'BxBlockAddress::Address', dependent: :destroy
    has_one  :user_event, class_name: 'BxBlockEvent::UserEvent', dependent: :destroy
    has_one  :life_event, through: :user_event, class_name: 'BxBlockEvent::LifeEvent', dependent: :destroy
    has_many :account_choice_skin_logs, as: :account, class_name: 'BxBlockFacialtracking::AccountChoiceSkinLog', dependent: :destroy, foreign_key: 'account_id'
    has_many :skin_log_choices, through: :account_choice_skin_logs, class_name: 'BxBlockFacialtracking::Choice', source: :skin_quiz, dependent: :destroy
    has_many :user_images, as: :account, class_name: 'BxBlockFacialtracking::UserImage', dependent: :destroy, foreign_key: :account_id
    has_many :orders, foreign_key: 'customer_id', class_name: 'BxBlockShoppingCart::Order', dependent: :destroy
    has_one  :account_choice_skin_goal, -> {joins(:skin_quiz).where('skin_quizzes.question_type = ?', "skin_goal")}, class_name: 'BxBlockFacialtracking::AccountChoiceSkinLog', dependent: :destroy
    has_many :customer_favourite_products, as: :account, dependent: :destroy, class_name: 'BxBlockCatalogue::CustomerFavouriteProduct'
    has_many :discount_code_usages, class_name: "BxBlockShopifyintegration::DiscountCodeUsage", dependent: :destroy
    has_many :cart_items, dependent: :destroy, class_name: 'BxBlockShoppingCart::CartItem'
    has_one :wallet, class_name: 'BxBlockPayments::Wallet', dependent: :destroy
    has_many :wallet_transactions, through: :wallet, dependent: :destroy
    has_many :membership_plans, class_name: 'BxBlockCustomisableusersubscriptions::MembershipPlan', dependent: :destroy
    accepts_nested_attributes_for :membership_plans
    has_many :questions, class_name: 'BxBlockCommunityforum::Question', dependent: :destroy, foreign_key: :accountable_id, as: :accountable
    has_many :comments, class_name: 'BxBlockCommunityforum::Comment', dependent: :destroy, foreign_key: :accountable_id, as: :accountable
    has_many :activities, class_name: 'BxBlockCommunityforum::Activity', dependent: :destroy, foreign_key: :accountable_id, as: :accountable
    has_many :saved, class_name: 'BxBlockCommunityforum::Saved', dependent: :destroy, foreign_key: :accountable_id, as: :accountable
    has_many :likes, class_name: 'BxBlockCommunityforum::Like', dependent: :destroy, foreign_key: :accountable_id, as: :accountable
    has_many :tutorial_likes, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubLike', dependent: :destroy
    has_many :video_likes, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubLike', dependent: :destroy
    has_many :views, class_name: 'BxBlockCommunityforum::View', dependent: :destroy, foreign_key: :accountable_id, as: :accountable
    has_many :user_activities, class_name: 'BxBlockCommunityforum::Activity', foreign_key: 'concern_mail_id' , dependent: :destroy
    has_many :notifications, as: :accountable, class_name: 'BxBlockNotifications::Notification', dependent: :destroy
    has_many :user_consultations, class_name: 'BxBlockConsultation::UserConsultation', dependent: :destroy
    has_many :account_choice_skin_consultations, -> {joins(:skin_quiz).where("skin_quizzes.question_type = ?", "consultation")},class_name: 'BxBlockFacialtracking::AccountChoiceSkinLog', dependent: :destroy
    has_many :customer_academy_subscriptions, class_name: 'BxBlockContentmanagement::CustomerAcademySubscription', dependent: :destroy
    has_many :payments, class_name: 'BxBlockPayments::Payment', dependent: :destroy
    has_many :therapist_notes, as: :therapist, class_name: 'AccountBlock::TherapistNote', dependent: :destroy, foreign_key: :therapist_id
    has_many :skincare_routine, as: :account, class_name: 'BxBlockSkinDiary::SkincareRoutine', dependent: :destroy, foreign_key: :account_id
    has_many :skincare_routines, as: :therapist, class_name: 'BxBlockSkinDiary::SkincareRoutine', dependent: :destroy, foreign_key: :therapist_id
    has_many :stories, as: :objectable, class_name: 'AccountBlock::Story', dependent: :destroy
    has_many :story_views, as: :accountable, class_name: 'AccountBlock::StoryView', dependent: :destroy
    has_many :chats, class_name: 'BxBlockChat::Chat', dependent: :destroy
    has_many :messages, as: :account, class_name: 'BxBlockChat::Message', dependent: :destroy
    has_many :customer_chats, as: :therapist, class_name: 'BxBlockChat::Chat', foreign_key: :therapist_id, dependent: :destroy
    has_many :reports, as: :accountable, class_name: 'BxBlockCommunityforum::Report', dependent: :destroy
    has_many :appointments, class_name: 'BxBlockAppointmentManagement::Appointment', dependent: :destroy
    has_many :subscriptions, class_name: 'BxBlockPayments::Subscription', foreign_key: :account_id, dependent: :destroy
    has_many :product_collection_views, as: :accountable, class_name: 'BxBlockCatalogue::ProductCollectionView', dependent: :destroy
    has_one :home_page_view, as: :accountable, class_name: 'BxBlockContentmanagement::HomePageView', dependent: :destroy
    has_many :customer_skin_journeys, as: :therapist, class_name: 'BxBlockFacialtracking::SkinJourney', dependent: :destroy, foreign_key: :therapist_id
    has_many :skin_journeys, class_name: 'BxBlockFacialtracking::SkinJourney', dependent: :destroy, foreign_key: :account_id
    has_many :account_notification_statuses, class_name: 'BxBlockNotifications::AccountNotificationStatus', dependent: :destroy
    has_many :active_hours, class_name: 'AccountBlock::ActiveHour', dependent: :destroy
    has_one :klaviyo_list, class_name: 'AccountBlock::KlaviyoList', dependent: :destroy
    has_many :page_clicks, as: :accountable, class_name: 'BxBlockSkinClinic::PageClick', dependent: :destroy
    has_many :recommended_products, as: :parentable, class_name: "BxBlockCatalogue::RecommendedProduct", dependent: :destroy#, foreign_key: :therapist_id
    
    self.table_name = :accounts

    include Wisper::Publisher

    has_secure_password

    has_one_attached :profile_pic
    has_one_attached :contact_us_primary_image
    has_one_attached :contact_us_secondary_image

    before_validation :parse_full_phone_number
    validate  :validate_image_content_type
    validates :email, presence: true, uniqueness: true
    validates :acuity_calendar, presence: true, uniqueness: true, :if => Proc.new { |account| account.role.name.downcase == "therapist" }
    validates :full_phone_number, length: {maximum: 14, minimum: 11}, numericality: {only_integer: true}, if: -> {full_phone_number.present?}
    validate  :valid_phone_number, if: -> {full_phone_number.present?}
    after_update :update_activated, if: -> {saved_change_to_is_deleted?}
    after_update :update_is_deleted, if: -> {saved_change_to_activated?}
    validate :unique_email

    before_update :send_block_email

    enum gender: {male: "male", female: "female", rather_not_say: "rather_not_say"}
    enum user_type: {'free': 1, 'glow_getter': 2, 'elite': 3}
    enum device: {android: 'android', ios: 'ios'}

    scope :active, -> {where(activated: true)}
    
    accepts_nested_attributes_for :addresses, allow_destroy: true
    accepts_nested_attributes_for :therapist_notes, allow_destroy: true

    def membership_plan
      membership = self.membership_plans.where('end_date > ?', Time.now).first
      membership.present? ? membership : self.therapist? ? {plan_type: "glow_getter"}:{plan_type: "free"}
    end
    
    def user?
      role.name.downcase == 'user'
    end

    def therapist?
      role.name.downcase == 'therapist'
    end

    def admin?
      role.name.downcase == "admin"
    end

    def send_confirmation_mail(url, token)
      EmailValidationMailer.with(account: self, host: url, token: token).activation_email.deliver
    end

    def send_password_mail(url, password)
      TherapistPasswordMailer.with(account: self, host: url, password: password).password_email.deliver
    end
    
    def name
      self.first_name.to_s + " " + self.last_name.to_s
    end

    def set_active
      self.activated = true
    end

    private

    def validate_image_content_type
      if profile_pic.present? && !["image/jpeg", "image/jpg", "image/png"].include?(profile_pic.content_type)
        errors.add(:base, "Profile picture must be in jpg or png format")
      end
    end

    def unique_email
      if AdminUser.pluck(:email).include?(self.email)
        errors.add(:email, "Email is already in use")
      end
    end

    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code      = phone.country_code
      self.phone_number      = phone.raw_national
    end

    def valid_phone_number
      unless Phonelib.valid?(full_phone_number)
        errors.add(:full_phone_number, "Invalid or Unrecognized Phone Number")
      end
    end

    def update_activated
      self.update(activated: !is_deleted)
    end

    def update_is_deleted
      self.update(is_deleted: !activated)
    end

    def self.send_abandoned_notifications
      Account.joins(:cart_items).uniq.each do |account|
        fcm = FCM.new(ENV["FIREBASE_SERVER_KEY"])
        registration_ids = [account&.device_token]
        title = "Cart"
        body = "Hello #{account&.name}, you have #{account.cart_items.map(&:name).join(", ")} in your cart. Order it now and get amazing discounts."
        options = { "notification":
                    {
                      "title": title,
                      "body": body
                    }
                  }
        response = fcm.send(registration_ids, options) if registration_ids.compact.present?
        account.notifications.create(headings: title, contents: body) if registration_ids.compact.present?
      end
    end

    def send_block_email
      if self.blocked_changed? && self.blocked
        payload_data = {account: self, notification_key: 'skin_hub', inapp: true, push_notification: true, all: false, type: 'skin_hub', notification_for: 'skin_hub', key: 'forum'}
        BxBlockPushNotifications::FcmSendNotification.new("You have been muted in our forums due to rule breaking. You no longer have the ability to post or comment, but can continue to access the forums.", "You have been muted in our forums.", self&.device_token, payload_data).call
        AccountBlock::AccountMailer.with(account: self).block_email.deliver
      end
    end

  end
end
