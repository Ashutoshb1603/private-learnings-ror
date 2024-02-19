class AdminUser < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable,
           :recoverable, :rememberable, :validatable

    belongs_to :role, class_name: 'BxBlockRolesPermissions::Role', optional: true
    has_many :questions, class_name: 'BxBlockCommunityforum::Question', foreign_key: :accountable_id, as: :accountable
    has_many :comments, class_name: 'BxBlockCommunityforum::Comment', foreign_key: :accountable_id, as: :accountable
    has_many :activities, class_name: 'BxBlockCommunityforum::Activity', foreign_key: :accountable_id, as: :accountable
    has_many :saved, class_name: 'BxBlockCommunityforum::Saved', foreign_key: :accountable_id, as: :accountable
    has_many :likes, class_name: 'BxBlockCommunityforum::Like', foreign_key: :accountable_id, as: :accountable
    has_many :tutorial_likes, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubLike'
    has_many :video_likes, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubLike'
    has_many :views, class_name: 'BxBlockCommunityforum::View', foreign_key: :accountable_id, as: :accountable
    has_many :notifications, as: :accountable, class_name: 'BxBlockNotifications::Notification', dependent: :destroy
    has_many :stories, as: :objectable, class_name: 'AccountBlock::Story', dependent: :destroy
    has_many :story_views, as: :accountable, class_name: 'AccountBlock::StoryView', dependent: :destroy
    has_many :addresses, as: :addressable, class_name: 'BxBlockAddress::Address', dependent: :destroy
    has_many :reports, as: :accountable, class_name: 'BxBlockCommunityforum::Report', dependent: :destroy
    has_many :product_collection_views, as: :accountable, class_name: 'BxBlockCatalogue::ProductCollectionView', dependent: :destroy
    has_many :home_page_view, as: :accountable, class_name: 'BxBlockContentmanagement::HomePageView', dependent: :destroy
    has_many :account_choice_skin_logs, as: :account, class_name: 'BxBlockFacialtracking::AccountChoiceSkinLog', dependent: :destroy, foreign_key: :account_id
    has_many :skin_log_choices, through: :account_choice_skin_logs, class_name: 'BxBlockFacialtracking::Choice', source: :skin_quiz, dependent: :destroy
    has_many :user_images, as: :account, class_name: 'BxBlockFacialtracking::UserImage', dependent: :destroy, foreign_key: :account_id
    has_many :customer_favourite_products, as: :account, dependent: :destroy, class_name: 'BxBlockCatalogue::CustomerFavouriteProduct'
    has_many :customer_chats, as: :therapist, class_name: 'BxBlockChat::Chat', foreign_key: :therapist_id, dependent: :destroy
    has_many :messages, as: :account, class_name: 'BxBlockChat::Message', dependent: :destroy
    has_many :therapist_notes, as: :therapist, class_name: 'AccountBlock::TherapistNote', dependent: :destroy, foreign_key: :therapist_id
    has_many :customer_skin_journeys, as: :therapist, class_name: 'BxBlockFacialtracking::SkinJourney', dependent: :destroy, foreign_key: :therapist_id
    has_many :skincare_routine, as: :account, class_name: 'BxBlockSkinDiary::SkincareRoutine', dependent: :destroy, foreign_key: :account_id
    has_many :skincare_routines, as: :therapist, class_name: 'BxBlockSkinDiary::SkincareRoutine', dependent: :destroy, foreign_key: :therapist_id
    has_many :page_clicks, as: :accountable, class_name: 'BxBlockSkinClinic::PageClick', dependent: :destroy
    has_many :recommended_product, as: :account, class_name: 'BxBlockCatalogue::RecommendedProduct', dependent: :destroy, foreign_key: :account_id
    has_many :recommended_products, as: :parentable, class_name: 'BxBlockCatalogue::RecommendedProduct', dependent: :destroy#, foreign_key: :therapist_id
    validate :unique_email

    
    has_one_attached :profile_pic

    accepts_nested_attributes_for :addresses, allow_destroy: true
    
    enum gender: {male: "male", female: "female", rather_not_say: "rather_not_say"}

    def unique_email
        if AccountBlock::Account.pluck(:email).include?(self.email)
            errors.add(:email, "Email is already in use")
        end
    end

    def type 
        "AdminAccount"
    end

    def name
        self&.first_name.to_s + " " + self&.last_name.to_s
    end

    def membership_plan
        {plan_type: "glow_getter"}
    end
end
