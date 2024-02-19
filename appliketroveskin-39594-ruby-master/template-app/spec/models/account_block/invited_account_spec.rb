require 'rails_helper'

describe AccountBlock::InvitedAccount, :type => :model do
  before(:all) { @account = build(:account) }
  subject { @account }
  # let (:subject) { build :account_block/invited_account }
  context "validation" do
    it "should validate_presence_of email" do
      subject.email = "test1@example.com"
      expect(subject).to be_valid
    end
    # it { should validate_presence_of :role }
    # it { should validate_presence_of :email }
    # it { should validate_presence_of :email }
    # it { should validate_presence_of :acuity_calendar }
    # it "length_validator test for [:password]"
    it "confirmation_validator test for [:password]" do
      should validate_confirmation_of :password
    end
    it "uniqueness_validator test for [:email]" do
      should validate_uniqueness_of :email
    end
    # it "uniqueness_validator test for [:acuity_calendar]"
    # it "length_validator test for [:full_phone_number]" do
    #   should validate_length_of(:full_phone_number).is_at_least(11).is_at_most(14)
    # end

    # it "numericality_validator test for [:full_phone_number]" do
    #   should validate_numericality_of :full_phone_number
    # end
  end
  context "associations" do
    it "should belong_to role" do
      subject.email = "test1@example.com"
      expect(subject).to be_valid
    end
    it { should have_many :account_choice_skin_quizzes }
    it { should have_many :choices }
    it { should have_many :tags }
    it { should have_many :addresses }
    it { should have_one :user_event }
    it { should have_one :life_event }
    it { should have_many :account_choice_skin_logs }
    it { should have_many :skin_log_choices }
    it { should have_many :user_images }
    it { should have_many :orders }
    it { should have_one :account_choice_skin_goal }
    it { should have_many :customer_favourite_products }
    it { should have_many :discount_code_usages }
    it { should have_many :cart_items }
    it { should have_one :wallet }
    it { should have_many :wallet_transactions }
    it { should have_many :membership_plans }
    it { should have_many :questions }
    it { should have_many :comments }
    it { should have_many :activities }
    it { should have_many :saved }
    it { should have_many :likes }
    it { should have_many :tutorial_likes }
    it { should have_many :video_likes }
    it { should have_many :views }
    it { should have_many :user_activities }
    it { should have_many :notifications }
    it { should have_many :user_consultations }
    it { should have_many :account_choice_skin_consultations }
    it { should have_many :customer_academy_subscriptions }
    it { should have_many :payments }
    it { should have_many :therapist_notes }
    it { should have_many :skincare_routine }
    it { should have_many :skincare_routines }
    it { should have_many :stories }
    it { should have_many :story_views }
    it { should have_many :chats }
    it { should have_many :messages }
    it { should have_many :customer_chats }
    it { should have_many :reports }
    it { should have_many :appointments }
    it { should have_many :subscriptions }
    it { should have_many :product_collection_views }
    it { should have_one :home_page_view }
    it { should have_many :customer_skin_journeys }
    it { should have_many :skin_journeys }
    it { should have_many :account_notification_statuses }
    it { should have_many :active_hours }
    it { should have_one :klaviyo_list }
    it { should have_many :page_clicks }
    it { should have_many :recommended_products }
    it { should have_one :profile_pic_attachment }
    it { should have_one :profile_pic_blob }
    it { should have_one :contact_us_primary_image_attachment }
    it { should have_one :contact_us_primary_image_blob }
    it { should have_one :contact_us_secondary_image_attachment }
    it { should have_one :contact_us_secondary_image_blob }
  end

end
