require 'rails_helper'

describe AdminUser, :type => :model do
  # let (:subject) { build :admin_user }
  context "validation" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    # it "uniqueness_validator test for [:email]" do
    #   should validate_uniqueness_of :email
    # end
    # it "format_validator test for [:email]"
    it "confirmation_validator test for [:password]" do
      should validate_confirmation_of :password
    end
    # it "length_validator test for [:password]"
  end
  context "associations" do
    # it { should belong_to :role }
    it { should have_many :questions }
    it { should have_many :comments }
    it { should have_many :activities }
    it { should have_many :saved }
    it { should have_many :likes }
    it { should have_many :tutorial_likes }
    it { should have_many :video_likes }
    it { should have_many :views }
    it { should have_many :notifications }
    it { should have_many :stories }
    it { should have_many :story_views }
    it { should have_many :addresses }
    it { should have_many :reports }
    it { should have_many :product_collection_views }
    it { should have_many :home_page_view }
    it { should have_many :account_choice_skin_logs }
    it { should have_many :skin_log_choices }
    it { should have_many :user_images }
    it { should have_many :customer_favourite_products }
    it { should have_many :customer_chats }
    it { should have_many :messages }
    it { should have_many :therapist_notes }
    it { should have_many :customer_skin_journeys }
    it { should have_many :skincare_routine }
    it { should have_many :skincare_routines }
    it { should have_many :page_clicks }
    it { should have_many :recommended_product }
    it { should have_many :recommended_products }
    it { should have_one :profile_pic_attachment }
    it { should have_one :profile_pic_blob }
  end
  context "after_add_for_account_choice_skin_logs" do
    it "exercises after_add_for_account_choice_skin_logs somehow" do
      subject.after_add_for_account_choice_skin_logs 
    end
  end
  context "after_add_for_account_choice_skin_logs=" do
    it "exercises after_add_for_account_choice_skin_logs= somehow" do
      subject.after_add_for_account_choice_skin_logs= 1
    end
  end
  context "after_add_for_account_choice_skin_logs?" do
    it "exercises after_add_for_account_choice_skin_logs? somehow" do
      subject.after_add_for_account_choice_skin_logs? 
    end
  end
  context "after_add_for_activities" do
    it "exercises after_add_for_activities somehow" do
      subject.after_add_for_activities 
    end
  end
  context "after_add_for_activities=" do
    it "exercises after_add_for_activities= somehow" do
      subject.after_add_for_activities= 1
    end
  end
  context "after_add_for_activities?" do
    it "exercises after_add_for_activities? somehow" do
      subject.after_add_for_activities? 
    end
  end
  context "after_add_for_addresses" do
    it "exercises after_add_for_addresses somehow" do
      subject.after_add_for_addresses 
    end
  end
  context "after_add_for_addresses=" do
    it "exercises after_add_for_addresses= somehow" do
      subject.after_add_for_addresses= 1
    end
  end
  context "after_add_for_addresses?" do
    it "exercises after_add_for_addresses? somehow" do
      subject.after_add_for_addresses? 
    end
  end
  context "after_add_for_comments" do
    it "exercises after_add_for_comments somehow" do
      subject.after_add_for_comments 
    end
  end
  context "after_add_for_comments=" do
    it "exercises after_add_for_comments= somehow" do
      subject.after_add_for_comments= 1
    end
  end
  context "after_add_for_comments?" do
    it "exercises after_add_for_comments? somehow" do
      subject.after_add_for_comments? 
    end
  end
  context "after_add_for_customer_chats" do
    it "exercises after_add_for_customer_chats somehow" do
      subject.after_add_for_customer_chats 
    end
  end
  context "after_add_for_customer_chats=" do
    it "exercises after_add_for_customer_chats= somehow" do
      subject.after_add_for_customer_chats= 1
    end
  end
  context "after_add_for_customer_chats?" do
    it "exercises after_add_for_customer_chats? somehow" do
      subject.after_add_for_customer_chats? 
    end
  end
  context "after_add_for_customer_favourite_products" do
    it "exercises after_add_for_customer_favourite_products somehow" do
      subject.after_add_for_customer_favourite_products 
    end
  end
  context "after_add_for_customer_favourite_products=" do
    it "exercises after_add_for_customer_favourite_products= somehow" do
      subject.after_add_for_customer_favourite_products= 1
    end
  end
  context "after_add_for_customer_favourite_products?" do
    it "exercises after_add_for_customer_favourite_products? somehow" do
      subject.after_add_for_customer_favourite_products? 
    end
  end
  context "after_add_for_customer_skin_journeys" do
    it "exercises after_add_for_customer_skin_journeys somehow" do
      subject.after_add_for_customer_skin_journeys 
    end
  end
  context "after_add_for_customer_skin_journeys=" do
    it "exercises after_add_for_customer_skin_journeys= somehow" do
      subject.after_add_for_customer_skin_journeys= 1
    end
  end
  context "after_add_for_customer_skin_journeys?" do
    it "exercises after_add_for_customer_skin_journeys? somehow" do
      subject.after_add_for_customer_skin_journeys? 
    end
  end
  context "after_add_for_home_page_view" do
    it "exercises after_add_for_home_page_view somehow" do
      subject.after_add_for_home_page_view 
    end
  end
  context "after_add_for_home_page_view=" do
    it "exercises after_add_for_home_page_view= somehow" do
      subject.after_add_for_home_page_view= 1
    end
  end
  context "after_add_for_home_page_view?" do
    it "exercises after_add_for_home_page_view? somehow" do
      subject.after_add_for_home_page_view? 
    end
  end
  context "after_add_for_likes" do
    it "exercises after_add_for_likes somehow" do
      subject.after_add_for_likes 
    end
  end
  context "after_add_for_likes=" do
    it "exercises after_add_for_likes= somehow" do
      subject.after_add_for_likes= 1
    end
  end
  context "after_add_for_likes?" do
    it "exercises after_add_for_likes? somehow" do
      subject.after_add_for_likes? 
    end
  end
  context "after_add_for_messages" do
    it "exercises after_add_for_messages somehow" do
      subject.after_add_for_messages 
    end
  end
  context "after_add_for_messages=" do
    it "exercises after_add_for_messages= somehow" do
      subject.after_add_for_messages= 1
    end
  end
  context "after_add_for_messages?" do
    it "exercises after_add_for_messages? somehow" do
      subject.after_add_for_messages? 
    end
  end
  context "after_add_for_notifications" do
    it "exercises after_add_for_notifications somehow" do
      subject.after_add_for_notifications 
    end
  end
  context "after_add_for_notifications=" do
    it "exercises after_add_for_notifications= somehow" do
      subject.after_add_for_notifications= 1
    end
  end
  context "after_add_for_notifications?" do
    it "exercises after_add_for_notifications? somehow" do
      subject.after_add_for_notifications? 
    end
  end
  context "after_add_for_page_clicks" do
    it "exercises after_add_for_page_clicks somehow" do
      subject.after_add_for_page_clicks 
    end
  end
  context "after_add_for_page_clicks=" do
    it "exercises after_add_for_page_clicks= somehow" do
      subject.after_add_for_page_clicks= 1
    end
  end
  context "after_add_for_page_clicks?" do
    it "exercises after_add_for_page_clicks? somehow" do
      subject.after_add_for_page_clicks? 
    end
  end
  context "after_add_for_product_collection_views" do
    it "exercises after_add_for_product_collection_views somehow" do
      subject.after_add_for_product_collection_views 
    end
  end
  context "after_add_for_product_collection_views=" do
    it "exercises after_add_for_product_collection_views= somehow" do
      subject.after_add_for_product_collection_views= 1
    end
  end
  context "after_add_for_product_collection_views?" do
    it "exercises after_add_for_product_collection_views? somehow" do
      subject.after_add_for_product_collection_views? 
    end
  end
  context "after_add_for_questions" do
    it "exercises after_add_for_questions somehow" do
      subject.after_add_for_questions 
    end
  end
  context "after_add_for_questions=" do
    it "exercises after_add_for_questions= somehow" do
      subject.after_add_for_questions= 1
    end
  end
  context "after_add_for_questions?" do
    it "exercises after_add_for_questions? somehow" do
      subject.after_add_for_questions? 
    end
  end
  context "after_add_for_recommended_product" do
    it "exercises after_add_for_recommended_product somehow" do
      subject.after_add_for_recommended_product 
    end
  end
  context "after_add_for_recommended_product=" do
    it "exercises after_add_for_recommended_product= somehow" do
      subject.after_add_for_recommended_product= 1
    end
  end
  context "after_add_for_recommended_product?" do
    it "exercises after_add_for_recommended_product? somehow" do
      subject.after_add_for_recommended_product? 
    end
  end
  context "after_add_for_recommended_products" do
    it "exercises after_add_for_recommended_products somehow" do
      subject.after_add_for_recommended_products 
    end
  end
  context "after_add_for_recommended_products=" do
    it "exercises after_add_for_recommended_products= somehow" do
      subject.after_add_for_recommended_products= 1
    end
  end
  context "after_add_for_recommended_products?" do
    it "exercises after_add_for_recommended_products? somehow" do
      subject.after_add_for_recommended_products? 
    end
  end
  context "after_add_for_reports" do
    it "exercises after_add_for_reports somehow" do
      subject.after_add_for_reports 
    end
  end
  context "after_add_for_reports=" do
    it "exercises after_add_for_reports= somehow" do
      subject.after_add_for_reports= 1
    end
  end
  context "after_add_for_reports?" do
    it "exercises after_add_for_reports? somehow" do
      subject.after_add_for_reports? 
    end
  end
  context "after_add_for_saved" do
    it "exercises after_add_for_saved somehow" do
      subject.after_add_for_saved 
    end
  end
  context "after_add_for_saved=" do
    it "exercises after_add_for_saved= somehow" do
      subject.after_add_for_saved= 1
    end
  end
  context "after_add_for_saved?" do
    it "exercises after_add_for_saved? somehow" do
      subject.after_add_for_saved? 
    end
  end
  context "after_add_for_skin_log_choices" do
    it "exercises after_add_for_skin_log_choices somehow" do
      subject.after_add_for_skin_log_choices 
    end
  end
  context "after_add_for_skin_log_choices=" do
    it "exercises after_add_for_skin_log_choices= somehow" do
      subject.after_add_for_skin_log_choices= 1
    end
  end
  context "after_add_for_skin_log_choices?" do
    it "exercises after_add_for_skin_log_choices? somehow" do
      subject.after_add_for_skin_log_choices? 
    end
  end
  context "after_add_for_skincare_routine" do
    it "exercises after_add_for_skincare_routine somehow" do
      subject.after_add_for_skincare_routine 
    end
  end
  context "after_add_for_skincare_routine=" do
    it "exercises after_add_for_skincare_routine= somehow" do
      subject.after_add_for_skincare_routine= 1
    end
  end
  context "after_add_for_skincare_routine?" do
    it "exercises after_add_for_skincare_routine? somehow" do
      subject.after_add_for_skincare_routine? 
    end
  end
  context "after_add_for_skincare_routines" do
    it "exercises after_add_for_skincare_routines somehow" do
      subject.after_add_for_skincare_routines 
    end
  end
  context "after_add_for_skincare_routines=" do
    it "exercises after_add_for_skincare_routines= somehow" do
      subject.after_add_for_skincare_routines= 1
    end
  end
  context "after_add_for_skincare_routines?" do
    it "exercises after_add_for_skincare_routines? somehow" do
      subject.after_add_for_skincare_routines? 
    end
  end
  context "after_add_for_stories" do
    it "exercises after_add_for_stories somehow" do
      subject.after_add_for_stories 
    end
  end
  context "after_add_for_stories=" do
    it "exercises after_add_for_stories= somehow" do
      subject.after_add_for_stories= 1
    end
  end
  context "after_add_for_stories?" do
    it "exercises after_add_for_stories? somehow" do
      subject.after_add_for_stories? 
    end
  end
  context "after_add_for_story_views" do
    it "exercises after_add_for_story_views somehow" do
      subject.after_add_for_story_views 
    end
  end
  context "after_add_for_story_views=" do
    it "exercises after_add_for_story_views= somehow" do
      subject.after_add_for_story_views= 1
    end
  end
  context "after_add_for_story_views?" do
    it "exercises after_add_for_story_views? somehow" do
      subject.after_add_for_story_views? 
    end
  end
  context "after_add_for_therapist_notes" do
    it "exercises after_add_for_therapist_notes somehow" do
      subject.after_add_for_therapist_notes 
    end
  end
  context "after_add_for_therapist_notes=" do
    it "exercises after_add_for_therapist_notes= somehow" do
      subject.after_add_for_therapist_notes= 1
    end
  end
  context "after_add_for_therapist_notes?" do
    it "exercises after_add_for_therapist_notes? somehow" do
      subject.after_add_for_therapist_notes? 
    end
  end
  context "after_add_for_tutorial_likes" do
    it "exercises after_add_for_tutorial_likes somehow" do
      subject.after_add_for_tutorial_likes 
    end
  end
  context "after_add_for_tutorial_likes=" do
    it "exercises after_add_for_tutorial_likes= somehow" do
      subject.after_add_for_tutorial_likes= 1
    end
  end
  context "after_add_for_tutorial_likes?" do
    it "exercises after_add_for_tutorial_likes? somehow" do
      subject.after_add_for_tutorial_likes? 
    end
  end
  context "after_add_for_user_images" do
    it "exercises after_add_for_user_images somehow" do
      subject.after_add_for_user_images 
    end
  end
  context "after_add_for_user_images=" do
    it "exercises after_add_for_user_images= somehow" do
      subject.after_add_for_user_images= 1
    end
  end
  context "after_add_for_user_images?" do
    it "exercises after_add_for_user_images? somehow" do
      subject.after_add_for_user_images? 
    end
  end
  context "after_add_for_video_likes" do
    it "exercises after_add_for_video_likes somehow" do
      subject.after_add_for_video_likes 
    end
  end
  context "after_add_for_video_likes=" do
    it "exercises after_add_for_video_likes= somehow" do
      subject.after_add_for_video_likes= 1
    end
  end
  context "after_add_for_video_likes?" do
    it "exercises after_add_for_video_likes? somehow" do
      subject.after_add_for_video_likes? 
    end
  end
  context "after_add_for_views" do
    it "exercises after_add_for_views somehow" do
      subject.after_add_for_views 
    end
  end
  context "after_add_for_views=" do
    it "exercises after_add_for_views= somehow" do
      subject.after_add_for_views= 1
    end
  end
  context "after_add_for_views?" do
    it "exercises after_add_for_views? somehow" do
      subject.after_add_for_views? 
    end
  end
  context "after_remove_for_account_choice_skin_logs" do
    it "exercises after_remove_for_account_choice_skin_logs somehow" do
      subject.after_remove_for_account_choice_skin_logs 
    end
  end
  context "after_remove_for_account_choice_skin_logs=" do
    it "exercises after_remove_for_account_choice_skin_logs= somehow" do
      subject.after_remove_for_account_choice_skin_logs= 1
    end
  end
  context "after_remove_for_account_choice_skin_logs?" do
    it "exercises after_remove_for_account_choice_skin_logs? somehow" do
      subject.after_remove_for_account_choice_skin_logs? 
    end
  end
  context "after_remove_for_activities" do
    it "exercises after_remove_for_activities somehow" do
      subject.after_remove_for_activities 
    end
  end
  context "after_remove_for_activities=" do
    it "exercises after_remove_for_activities= somehow" do
      subject.after_remove_for_activities= 1
    end
  end
  context "after_remove_for_activities?" do
    it "exercises after_remove_for_activities? somehow" do
      subject.after_remove_for_activities? 
    end
  end
  context "after_remove_for_addresses" do
    it "exercises after_remove_for_addresses somehow" do
      subject.after_remove_for_addresses 
    end
  end
  context "after_remove_for_addresses=" do
    it "exercises after_remove_for_addresses= somehow" do
      subject.after_remove_for_addresses= 1
    end
  end
  context "after_remove_for_addresses?" do
    it "exercises after_remove_for_addresses? somehow" do
      subject.after_remove_for_addresses? 
    end
  end
  context "after_remove_for_comments" do
    it "exercises after_remove_for_comments somehow" do
      subject.after_remove_for_comments 
    end
  end
  context "after_remove_for_comments=" do
    it "exercises after_remove_for_comments= somehow" do
      subject.after_remove_for_comments= 1
    end
  end
  context "after_remove_for_comments?" do
    it "exercises after_remove_for_comments? somehow" do
      subject.after_remove_for_comments? 
    end
  end
  context "after_remove_for_customer_chats" do
    it "exercises after_remove_for_customer_chats somehow" do
      subject.after_remove_for_customer_chats 
    end
  end
  context "after_remove_for_customer_chats=" do
    it "exercises after_remove_for_customer_chats= somehow" do
      subject.after_remove_for_customer_chats= 1
    end
  end
  context "after_remove_for_customer_chats?" do
    it "exercises after_remove_for_customer_chats? somehow" do
      subject.after_remove_for_customer_chats? 
    end
  end
  context "after_remove_for_customer_favourite_products" do
    it "exercises after_remove_for_customer_favourite_products somehow" do
      subject.after_remove_for_customer_favourite_products 
    end
  end
  context "after_remove_for_customer_favourite_products=" do
    it "exercises after_remove_for_customer_favourite_products= somehow" do
      subject.after_remove_for_customer_favourite_products= 1
    end
  end
  context "after_remove_for_customer_favourite_products?" do
    it "exercises after_remove_for_customer_favourite_products? somehow" do
      subject.after_remove_for_customer_favourite_products? 
    end
  end
  context "after_remove_for_customer_skin_journeys" do
    it "exercises after_remove_for_customer_skin_journeys somehow" do
      subject.after_remove_for_customer_skin_journeys 
    end
  end
  context "after_remove_for_customer_skin_journeys=" do
    it "exercises after_remove_for_customer_skin_journeys= somehow" do
      subject.after_remove_for_customer_skin_journeys= 1
    end
  end
  context "after_remove_for_customer_skin_journeys?" do
    it "exercises after_remove_for_customer_skin_journeys? somehow" do
      subject.after_remove_for_customer_skin_journeys? 
    end
  end
  context "after_remove_for_home_page_view" do
    it "exercises after_remove_for_home_page_view somehow" do
      subject.after_remove_for_home_page_view 
    end
  end
  context "after_remove_for_home_page_view=" do
    it "exercises after_remove_for_home_page_view= somehow" do
      subject.after_remove_for_home_page_view= 1
    end
  end
  context "after_remove_for_home_page_view?" do
    it "exercises after_remove_for_home_page_view? somehow" do
      subject.after_remove_for_home_page_view? 
    end
  end
  context "after_remove_for_likes" do
    it "exercises after_remove_for_likes somehow" do
      subject.after_remove_for_likes 
    end
  end
  context "after_remove_for_likes=" do
    it "exercises after_remove_for_likes= somehow" do
      subject.after_remove_for_likes= 1
    end
  end
  context "after_remove_for_likes?" do
    it "exercises after_remove_for_likes? somehow" do
      subject.after_remove_for_likes? 
    end
  end
  context "after_remove_for_messages" do
    it "exercises after_remove_for_messages somehow" do
      subject.after_remove_for_messages 
    end
  end
  context "after_remove_for_messages=" do
    it "exercises after_remove_for_messages= somehow" do
      subject.after_remove_for_messages= 1
    end
  end
  context "after_remove_for_messages?" do
    it "exercises after_remove_for_messages? somehow" do
      subject.after_remove_for_messages? 
    end
  end
  context "after_remove_for_notifications" do
    it "exercises after_remove_for_notifications somehow" do
      subject.after_remove_for_notifications 
    end
  end
  context "after_remove_for_notifications=" do
    it "exercises after_remove_for_notifications= somehow" do
      subject.after_remove_for_notifications= 1
    end
  end
  context "after_remove_for_notifications?" do
    it "exercises after_remove_for_notifications? somehow" do
      subject.after_remove_for_notifications? 
    end
  end
  context "after_remove_for_page_clicks" do
    it "exercises after_remove_for_page_clicks somehow" do
      subject.after_remove_for_page_clicks 
    end
  end
  context "after_remove_for_page_clicks=" do
    it "exercises after_remove_for_page_clicks= somehow" do
      subject.after_remove_for_page_clicks= 1
    end
  end
  context "after_remove_for_page_clicks?" do
    it "exercises after_remove_for_page_clicks? somehow" do
      subject.after_remove_for_page_clicks? 
    end
  end
  context "after_remove_for_product_collection_views" do
    it "exercises after_remove_for_product_collection_views somehow" do
      subject.after_remove_for_product_collection_views 
    end
  end
  context "after_remove_for_product_collection_views=" do
    it "exercises after_remove_for_product_collection_views= somehow" do
      subject.after_remove_for_product_collection_views= 1
    end
  end
  context "after_remove_for_product_collection_views?" do
    it "exercises after_remove_for_product_collection_views? somehow" do
      subject.after_remove_for_product_collection_views? 
    end
  end
  context "after_remove_for_questions" do
    it "exercises after_remove_for_questions somehow" do
      subject.after_remove_for_questions 
    end
  end
  context "after_remove_for_questions=" do
    it "exercises after_remove_for_questions= somehow" do
      subject.after_remove_for_questions= 1
    end
  end
  context "after_remove_for_questions?" do
    it "exercises after_remove_for_questions? somehow" do
      subject.after_remove_for_questions? 
    end
  end
  context "after_remove_for_recommended_product" do
    it "exercises after_remove_for_recommended_product somehow" do
      subject.after_remove_for_recommended_product 
    end
  end
  context "after_remove_for_recommended_product=" do
    it "exercises after_remove_for_recommended_product= somehow" do
      subject.after_remove_for_recommended_product= 1
    end
  end
  context "after_remove_for_recommended_product?" do
    it "exercises after_remove_for_recommended_product? somehow" do
      subject.after_remove_for_recommended_product? 
    end
  end
  context "after_remove_for_recommended_products" do
    it "exercises after_remove_for_recommended_products somehow" do
      subject.after_remove_for_recommended_products 
    end
  end
  context "after_remove_for_recommended_products=" do
    it "exercises after_remove_for_recommended_products= somehow" do
      subject.after_remove_for_recommended_products= 1
    end
  end
  context "after_remove_for_recommended_products?" do
    it "exercises after_remove_for_recommended_products? somehow" do
      subject.after_remove_for_recommended_products? 
    end
  end
  context "after_remove_for_reports" do
    it "exercises after_remove_for_reports somehow" do
      subject.after_remove_for_reports 
    end
  end
  context "after_remove_for_reports=" do
    it "exercises after_remove_for_reports= somehow" do
      subject.after_remove_for_reports= 1
    end
  end
  context "after_remove_for_reports?" do
    it "exercises after_remove_for_reports? somehow" do
      subject.after_remove_for_reports? 
    end
  end
  context "after_remove_for_saved" do
    it "exercises after_remove_for_saved somehow" do
      subject.after_remove_for_saved 
    end
  end
  context "after_remove_for_saved=" do
    it "exercises after_remove_for_saved= somehow" do
      subject.after_remove_for_saved= 1
    end
  end
  context "after_remove_for_saved?" do
    it "exercises after_remove_for_saved? somehow" do
      subject.after_remove_for_saved? 
    end
  end
  context "after_remove_for_skin_log_choices" do
    it "exercises after_remove_for_skin_log_choices somehow" do
      subject.after_remove_for_skin_log_choices 
    end
  end
  context "after_remove_for_skin_log_choices=" do
    it "exercises after_remove_for_skin_log_choices= somehow" do
      subject.after_remove_for_skin_log_choices= 1
    end
  end
  context "after_remove_for_skin_log_choices?" do
    it "exercises after_remove_for_skin_log_choices? somehow" do
      subject.after_remove_for_skin_log_choices? 
    end
  end
  context "after_remove_for_skincare_routine" do
    it "exercises after_remove_for_skincare_routine somehow" do
      subject.after_remove_for_skincare_routine 
    end
  end
  context "after_remove_for_skincare_routine=" do
    it "exercises after_remove_for_skincare_routine= somehow" do
      subject.after_remove_for_skincare_routine= 1
    end
  end
  context "after_remove_for_skincare_routine?" do
    it "exercises after_remove_for_skincare_routine? somehow" do
      subject.after_remove_for_skincare_routine? 
    end
  end
  context "after_remove_for_skincare_routines" do
    it "exercises after_remove_for_skincare_routines somehow" do
      subject.after_remove_for_skincare_routines 
    end
  end
  context "after_remove_for_skincare_routines=" do
    it "exercises after_remove_for_skincare_routines= somehow" do
      subject.after_remove_for_skincare_routines= 1
    end
  end
  context "after_remove_for_skincare_routines?" do
    it "exercises after_remove_for_skincare_routines? somehow" do
      subject.after_remove_for_skincare_routines? 
    end
  end
  context "after_remove_for_stories" do
    it "exercises after_remove_for_stories somehow" do
      subject.after_remove_for_stories 
    end
  end
  context "after_remove_for_stories=" do
    it "exercises after_remove_for_stories= somehow" do
      subject.after_remove_for_stories= 1
    end
  end
  context "after_remove_for_stories?" do
    it "exercises after_remove_for_stories? somehow" do
      subject.after_remove_for_stories? 
    end
  end
  context "after_remove_for_story_views" do
    it "exercises after_remove_for_story_views somehow" do
      subject.after_remove_for_story_views 
    end
  end
  context "after_remove_for_story_views=" do
    it "exercises after_remove_for_story_views= somehow" do
      subject.after_remove_for_story_views= 1
    end
  end
  context "after_remove_for_story_views?" do
    it "exercises after_remove_for_story_views? somehow" do
      subject.after_remove_for_story_views? 
    end
  end
  context "after_remove_for_therapist_notes" do
    it "exercises after_remove_for_therapist_notes somehow" do
      subject.after_remove_for_therapist_notes 
    end
  end
  context "after_remove_for_therapist_notes=" do
    it "exercises after_remove_for_therapist_notes= somehow" do
      subject.after_remove_for_therapist_notes= 1
    end
  end
  context "after_remove_for_therapist_notes?" do
    it "exercises after_remove_for_therapist_notes? somehow" do
      subject.after_remove_for_therapist_notes? 
    end
  end
  context "after_remove_for_tutorial_likes" do
    it "exercises after_remove_for_tutorial_likes somehow" do
      subject.after_remove_for_tutorial_likes 
    end
  end
  context "after_remove_for_tutorial_likes=" do
    it "exercises after_remove_for_tutorial_likes= somehow" do
      subject.after_remove_for_tutorial_likes= 1
    end
  end
  context "after_remove_for_tutorial_likes?" do
    it "exercises after_remove_for_tutorial_likes? somehow" do
      subject.after_remove_for_tutorial_likes? 
    end
  end
  context "after_remove_for_user_images" do
    it "exercises after_remove_for_user_images somehow" do
      subject.after_remove_for_user_images 
    end
  end
  context "after_remove_for_user_images=" do
    it "exercises after_remove_for_user_images= somehow" do
      subject.after_remove_for_user_images= 1
    end
  end
  context "after_remove_for_user_images?" do
    it "exercises after_remove_for_user_images? somehow" do
      subject.after_remove_for_user_images? 
    end
  end
  context "after_remove_for_video_likes" do
    it "exercises after_remove_for_video_likes somehow" do
      subject.after_remove_for_video_likes 
    end
  end
  context "after_remove_for_video_likes=" do
    it "exercises after_remove_for_video_likes= somehow" do
      subject.after_remove_for_video_likes= 1
    end
  end
  context "after_remove_for_video_likes?" do
    it "exercises after_remove_for_video_likes? somehow" do
      subject.after_remove_for_video_likes? 
    end
  end
  context "after_remove_for_views" do
    it "exercises after_remove_for_views somehow" do
      subject.after_remove_for_views 
    end
  end
  context "after_remove_for_views=" do
    it "exercises after_remove_for_views= somehow" do
      subject.after_remove_for_views= 1
    end
  end
  context "after_remove_for_views?" do
    it "exercises after_remove_for_views? somehow" do
      subject.after_remove_for_views? 
    end
  end
  context "autosave_associated_records_for_account_choice_skin_logs" do
    it "exercises autosave_associated_records_for_account_choice_skin_logs somehow" do
      subject.autosave_associated_records_for_account_choice_skin_logs 
    end
  end
  context "autosave_associated_records_for_activities" do
    it "exercises autosave_associated_records_for_activities somehow" do
      subject.autosave_associated_records_for_activities 
    end
  end
  context "autosave_associated_records_for_addresses" do
    it "exercises autosave_associated_records_for_addresses somehow" do
      subject.autosave_associated_records_for_addresses 
    end
  end
  context "autosave_associated_records_for_comments" do
    it "exercises autosave_associated_records_for_comments somehow" do
      subject.autosave_associated_records_for_comments 
    end
  end
  context "autosave_associated_records_for_customer_chats" do
    it "exercises autosave_associated_records_for_customer_chats somehow" do
      subject.autosave_associated_records_for_customer_chats 
    end
  end
  context "autosave_associated_records_for_customer_favourite_products" do
    it "exercises autosave_associated_records_for_customer_favourite_products somehow" do
      subject.autosave_associated_records_for_customer_favourite_products 
    end
  end
  context "autosave_associated_records_for_customer_skin_journeys" do
    it "exercises autosave_associated_records_for_customer_skin_journeys somehow" do
      subject.autosave_associated_records_for_customer_skin_journeys 
    end
  end
  context "autosave_associated_records_for_home_page_view" do
    it "exercises autosave_associated_records_for_home_page_view somehow" do
      subject.autosave_associated_records_for_home_page_view 
    end
  end
  context "autosave_associated_records_for_likes" do
    it "exercises autosave_associated_records_for_likes somehow" do
      subject.autosave_associated_records_for_likes 
    end
  end
  context "autosave_associated_records_for_messages" do
    it "exercises autosave_associated_records_for_messages somehow" do
      subject.autosave_associated_records_for_messages 
    end
  end
  context "autosave_associated_records_for_notifications" do
    it "exercises autosave_associated_records_for_notifications somehow" do
      subject.autosave_associated_records_for_notifications 
    end
  end
  context "autosave_associated_records_for_page_clicks" do
    it "exercises autosave_associated_records_for_page_clicks somehow" do
      subject.autosave_associated_records_for_page_clicks 
    end
  end
  context "autosave_associated_records_for_product_collection_views" do
    it "exercises autosave_associated_records_for_product_collection_views somehow" do
      subject.autosave_associated_records_for_product_collection_views 
    end
  end
  context "autosave_associated_records_for_profile_pic_attachment" do
    it "exercises autosave_associated_records_for_profile_pic_attachment somehow" do
      subject.autosave_associated_records_for_profile_pic_attachment 
    end
  end
  context "autosave_associated_records_for_profile_pic_blob" do
    it "exercises autosave_associated_records_for_profile_pic_blob somehow" do
      subject.autosave_associated_records_for_profile_pic_blob 
    end
  end
  context "autosave_associated_records_for_questions" do
    it "exercises autosave_associated_records_for_questions somehow" do
      subject.autosave_associated_records_for_questions 
    end
  end
  context "autosave_associated_records_for_recommended_product" do
    it "exercises autosave_associated_records_for_recommended_product somehow" do
      subject.autosave_associated_records_for_recommended_product 
    end
  end
  context "autosave_associated_records_for_recommended_products" do
    it "exercises autosave_associated_records_for_recommended_products somehow" do
      subject.autosave_associated_records_for_recommended_products 
    end
  end
  context "autosave_associated_records_for_reports" do
    it "exercises autosave_associated_records_for_reports somehow" do
      subject.autosave_associated_records_for_reports 
    end
  end
  context "autosave_associated_records_for_role" do
    it "exercises autosave_associated_records_for_role somehow" do
      subject.autosave_associated_records_for_role 
    end
  end
  context "autosave_associated_records_for_saved" do
    it "exercises autosave_associated_records_for_saved somehow" do
      subject.autosave_associated_records_for_saved 
    end
  end
  context "autosave_associated_records_for_skin_log_choices" do
    it "exercises autosave_associated_records_for_skin_log_choices somehow" do
      subject.autosave_associated_records_for_skin_log_choices 
    end
  end
  context "autosave_associated_records_for_skincare_routine" do
    it "exercises autosave_associated_records_for_skincare_routine somehow" do
      subject.autosave_associated_records_for_skincare_routine 
    end
  end
  context "autosave_associated_records_for_skincare_routines" do
    it "exercises autosave_associated_records_for_skincare_routines somehow" do
      subject.autosave_associated_records_for_skincare_routines 
    end
  end
  context "autosave_associated_records_for_stories" do
    it "exercises autosave_associated_records_for_stories somehow" do
      subject.autosave_associated_records_for_stories 
    end
  end
  context "autosave_associated_records_for_story_views" do
    it "exercises autosave_associated_records_for_story_views somehow" do
      subject.autosave_associated_records_for_story_views 
    end
  end
  context "autosave_associated_records_for_therapist_notes" do
    it "exercises autosave_associated_records_for_therapist_notes somehow" do
      subject.autosave_associated_records_for_therapist_notes 
    end
  end
  context "autosave_associated_records_for_tutorial_likes" do
    it "exercises autosave_associated_records_for_tutorial_likes somehow" do
      subject.autosave_associated_records_for_tutorial_likes 
    end
  end
  context "autosave_associated_records_for_user_images" do
    it "exercises autosave_associated_records_for_user_images somehow" do
      subject.autosave_associated_records_for_user_images 
    end
  end
  context "autosave_associated_records_for_video_likes" do
    it "exercises autosave_associated_records_for_video_likes somehow" do
      subject.autosave_associated_records_for_video_likes 
    end
  end
  context "autosave_associated_records_for_views" do
    it "exercises autosave_associated_records_for_views somehow" do
      subject.autosave_associated_records_for_views 
    end
  end
  context "before_add_for_account_choice_skin_logs" do
    it "exercises before_add_for_account_choice_skin_logs somehow" do
      subject.before_add_for_account_choice_skin_logs 
    end
  end
  context "before_add_for_account_choice_skin_logs=" do
    it "exercises before_add_for_account_choice_skin_logs= somehow" do
      subject.before_add_for_account_choice_skin_logs= 1
    end
  end
  context "before_add_for_account_choice_skin_logs?" do
    it "exercises before_add_for_account_choice_skin_logs? somehow" do
      subject.before_add_for_account_choice_skin_logs? 
    end
  end
  context "before_add_for_activities" do
    it "exercises before_add_for_activities somehow" do
      subject.before_add_for_activities 
    end
  end
  context "before_add_for_activities=" do
    it "exercises before_add_for_activities= somehow" do
      subject.before_add_for_activities= 1
    end
  end
  context "before_add_for_activities?" do
    it "exercises before_add_for_activities? somehow" do
      subject.before_add_for_activities? 
    end
  end
  context "before_add_for_addresses" do
    it "exercises before_add_for_addresses somehow" do
      subject.before_add_for_addresses 
    end
  end
  context "before_add_for_addresses=" do
    it "exercises before_add_for_addresses= somehow" do
      subject.before_add_for_addresses= 1
    end
  end
  context "before_add_for_addresses?" do
    it "exercises before_add_for_addresses? somehow" do
      subject.before_add_for_addresses? 
    end
  end
  context "before_add_for_comments" do
    it "exercises before_add_for_comments somehow" do
      subject.before_add_for_comments 
    end
  end
  context "before_add_for_comments=" do
    it "exercises before_add_for_comments= somehow" do
      subject.before_add_for_comments= 1
    end
  end
  context "before_add_for_comments?" do
    it "exercises before_add_for_comments? somehow" do
      subject.before_add_for_comments? 
    end
  end
  context "before_add_for_customer_chats" do
    it "exercises before_add_for_customer_chats somehow" do
      subject.before_add_for_customer_chats 
    end
  end
  context "before_add_for_customer_chats=" do
    it "exercises before_add_for_customer_chats= somehow" do
      subject.before_add_for_customer_chats= 1
    end
  end
  context "before_add_for_customer_chats?" do
    it "exercises before_add_for_customer_chats? somehow" do
      subject.before_add_for_customer_chats? 
    end
  end
  context "before_add_for_customer_favourite_products" do
    it "exercises before_add_for_customer_favourite_products somehow" do
      subject.before_add_for_customer_favourite_products 
    end
  end
  context "before_add_for_customer_favourite_products=" do
    it "exercises before_add_for_customer_favourite_products= somehow" do
      subject.before_add_for_customer_favourite_products= 1
    end
  end
  context "before_add_for_customer_favourite_products?" do
    it "exercises before_add_for_customer_favourite_products? somehow" do
      subject.before_add_for_customer_favourite_products? 
    end
  end
  context "before_add_for_customer_skin_journeys" do
    it "exercises before_add_for_customer_skin_journeys somehow" do
      subject.before_add_for_customer_skin_journeys 
    end
  end
  context "before_add_for_customer_skin_journeys=" do
    it "exercises before_add_for_customer_skin_journeys= somehow" do
      subject.before_add_for_customer_skin_journeys= 1
    end
  end
  context "before_add_for_customer_skin_journeys?" do
    it "exercises before_add_for_customer_skin_journeys? somehow" do
      subject.before_add_for_customer_skin_journeys? 
    end
  end
  context "before_add_for_home_page_view" do
    it "exercises before_add_for_home_page_view somehow" do
      subject.before_add_for_home_page_view 
    end
  end
  context "before_add_for_home_page_view=" do
    it "exercises before_add_for_home_page_view= somehow" do
      subject.before_add_for_home_page_view= 1
    end
  end
  context "before_add_for_home_page_view?" do
    it "exercises before_add_for_home_page_view? somehow" do
      subject.before_add_for_home_page_view? 
    end
  end
  context "before_add_for_likes" do
    it "exercises before_add_for_likes somehow" do
      subject.before_add_for_likes 
    end
  end
  context "before_add_for_likes=" do
    it "exercises before_add_for_likes= somehow" do
      subject.before_add_for_likes= 1
    end
  end
  context "before_add_for_likes?" do
    it "exercises before_add_for_likes? somehow" do
      subject.before_add_for_likes? 
    end
  end
  context "before_add_for_messages" do
    it "exercises before_add_for_messages somehow" do
      subject.before_add_for_messages 
    end
  end
  context "before_add_for_messages=" do
    it "exercises before_add_for_messages= somehow" do
      subject.before_add_for_messages= 1
    end
  end
  context "before_add_for_messages?" do
    it "exercises before_add_for_messages? somehow" do
      subject.before_add_for_messages? 
    end
  end
  context "before_add_for_notifications" do
    it "exercises before_add_for_notifications somehow" do
      subject.before_add_for_notifications 
    end
  end
  context "before_add_for_notifications=" do
    it "exercises before_add_for_notifications= somehow" do
      subject.before_add_for_notifications= 1
    end
  end
  context "before_add_for_notifications?" do
    it "exercises before_add_for_notifications? somehow" do
      subject.before_add_for_notifications? 
    end
  end
  context "before_add_for_page_clicks" do
    it "exercises before_add_for_page_clicks somehow" do
      subject.before_add_for_page_clicks 
    end
  end
  context "before_add_for_page_clicks=" do
    it "exercises before_add_for_page_clicks= somehow" do
      subject.before_add_for_page_clicks= 1
    end
  end
  context "before_add_for_page_clicks?" do
    it "exercises before_add_for_page_clicks? somehow" do
      subject.before_add_for_page_clicks? 
    end
  end
  context "before_add_for_product_collection_views" do
    it "exercises before_add_for_product_collection_views somehow" do
      subject.before_add_for_product_collection_views 
    end
  end
  context "before_add_for_product_collection_views=" do
    it "exercises before_add_for_product_collection_views= somehow" do
      subject.before_add_for_product_collection_views= 1
    end
  end
  context "before_add_for_product_collection_views?" do
    it "exercises before_add_for_product_collection_views? somehow" do
      subject.before_add_for_product_collection_views? 
    end
  end
  context "before_add_for_questions" do
    it "exercises before_add_for_questions somehow" do
      subject.before_add_for_questions 
    end
  end
  context "before_add_for_questions=" do
    it "exercises before_add_for_questions= somehow" do
      subject.before_add_for_questions= 1
    end
  end
  context "before_add_for_questions?" do
    it "exercises before_add_for_questions? somehow" do
      subject.before_add_for_questions? 
    end
  end
  context "before_add_for_recommended_product" do
    it "exercises before_add_for_recommended_product somehow" do
      subject.before_add_for_recommended_product 
    end
  end
  context "before_add_for_recommended_product=" do
    it "exercises before_add_for_recommended_product= somehow" do
      subject.before_add_for_recommended_product= 1
    end
  end
  context "before_add_for_recommended_product?" do
    it "exercises before_add_for_recommended_product? somehow" do
      subject.before_add_for_recommended_product? 
    end
  end
  context "before_add_for_recommended_products" do
    it "exercises before_add_for_recommended_products somehow" do
      subject.before_add_for_recommended_products 
    end
  end
  context "before_add_for_recommended_products=" do
    it "exercises before_add_for_recommended_products= somehow" do
      subject.before_add_for_recommended_products= 1
    end
  end
  context "before_add_for_recommended_products?" do
    it "exercises before_add_for_recommended_products? somehow" do
      subject.before_add_for_recommended_products? 
    end
  end
  context "before_add_for_reports" do
    it "exercises before_add_for_reports somehow" do
      subject.before_add_for_reports 
    end
  end
  context "before_add_for_reports=" do
    it "exercises before_add_for_reports= somehow" do
      subject.before_add_for_reports= 1
    end
  end
  context "before_add_for_reports?" do
    it "exercises before_add_for_reports? somehow" do
      subject.before_add_for_reports? 
    end
  end
  context "before_add_for_saved" do
    it "exercises before_add_for_saved somehow" do
      subject.before_add_for_saved 
    end
  end
  context "before_add_for_saved=" do
    it "exercises before_add_for_saved= somehow" do
      subject.before_add_for_saved= 1
    end
  end
  context "before_add_for_saved?" do
    it "exercises before_add_for_saved? somehow" do
      subject.before_add_for_saved? 
    end
  end
  context "before_add_for_skin_log_choices" do
    it "exercises before_add_for_skin_log_choices somehow" do
      subject.before_add_for_skin_log_choices 
    end
  end
  context "before_add_for_skin_log_choices=" do
    it "exercises before_add_for_skin_log_choices= somehow" do
      subject.before_add_for_skin_log_choices= 1
    end
  end
  context "before_add_for_skin_log_choices?" do
    it "exercises before_add_for_skin_log_choices? somehow" do
      subject.before_add_for_skin_log_choices? 
    end
  end
  context "before_add_for_skincare_routine" do
    it "exercises before_add_for_skincare_routine somehow" do
      subject.before_add_for_skincare_routine 
    end
  end
  context "before_add_for_skincare_routine=" do
    it "exercises before_add_for_skincare_routine= somehow" do
      subject.before_add_for_skincare_routine= 1
    end
  end
  context "before_add_for_skincare_routine?" do
    it "exercises before_add_for_skincare_routine? somehow" do
      subject.before_add_for_skincare_routine? 
    end
  end
  context "before_add_for_skincare_routines" do
    it "exercises before_add_for_skincare_routines somehow" do
      subject.before_add_for_skincare_routines 
    end
  end
  context "before_add_for_skincare_routines=" do
    it "exercises before_add_for_skincare_routines= somehow" do
      subject.before_add_for_skincare_routines= 1
    end
  end
  context "before_add_for_skincare_routines?" do
    it "exercises before_add_for_skincare_routines? somehow" do
      subject.before_add_for_skincare_routines? 
    end
  end
  context "before_add_for_stories" do
    it "exercises before_add_for_stories somehow" do
      subject.before_add_for_stories 
    end
  end
  context "before_add_for_stories=" do
    it "exercises before_add_for_stories= somehow" do
      subject.before_add_for_stories= 1
    end
  end
  context "before_add_for_stories?" do
    it "exercises before_add_for_stories? somehow" do
      subject.before_add_for_stories? 
    end
  end
  context "before_add_for_story_views" do
    it "exercises before_add_for_story_views somehow" do
      subject.before_add_for_story_views 
    end
  end
  context "before_add_for_story_views=" do
    it "exercises before_add_for_story_views= somehow" do
      subject.before_add_for_story_views= 1
    end
  end
  context "before_add_for_story_views?" do
    it "exercises before_add_for_story_views? somehow" do
      subject.before_add_for_story_views? 
    end
  end
  context "before_add_for_therapist_notes" do
    it "exercises before_add_for_therapist_notes somehow" do
      subject.before_add_for_therapist_notes 
    end
  end
  context "before_add_for_therapist_notes=" do
    it "exercises before_add_for_therapist_notes= somehow" do
      subject.before_add_for_therapist_notes= 1
    end
  end
  context "before_add_for_therapist_notes?" do
    it "exercises before_add_for_therapist_notes? somehow" do
      subject.before_add_for_therapist_notes? 
    end
  end
  context "before_add_for_tutorial_likes" do
    it "exercises before_add_for_tutorial_likes somehow" do
      subject.before_add_for_tutorial_likes 
    end
  end
  context "before_add_for_tutorial_likes=" do
    it "exercises before_add_for_tutorial_likes= somehow" do
      subject.before_add_for_tutorial_likes= 1
    end
  end
  context "before_add_for_tutorial_likes?" do
    it "exercises before_add_for_tutorial_likes? somehow" do
      subject.before_add_for_tutorial_likes? 
    end
  end
  context "before_add_for_user_images" do
    it "exercises before_add_for_user_images somehow" do
      subject.before_add_for_user_images 
    end
  end
  context "before_add_for_user_images=" do
    it "exercises before_add_for_user_images= somehow" do
      subject.before_add_for_user_images= 1
    end
  end
  context "before_add_for_user_images?" do
    it "exercises before_add_for_user_images? somehow" do
      subject.before_add_for_user_images? 
    end
  end
  context "before_add_for_video_likes" do
    it "exercises before_add_for_video_likes somehow" do
      subject.before_add_for_video_likes 
    end
  end
  context "before_add_for_video_likes=" do
    it "exercises before_add_for_video_likes= somehow" do
      subject.before_add_for_video_likes= 1
    end
  end
  context "before_add_for_video_likes?" do
    it "exercises before_add_for_video_likes? somehow" do
      subject.before_add_for_video_likes? 
    end
  end
  context "before_add_for_views" do
    it "exercises before_add_for_views somehow" do
      subject.before_add_for_views 
    end
  end
  context "before_add_for_views=" do
    it "exercises before_add_for_views= somehow" do
      subject.before_add_for_views= 1
    end
  end
  context "before_add_for_views?" do
    it "exercises before_add_for_views? somehow" do
      subject.before_add_for_views? 
    end
  end
  context "before_remove_for_account_choice_skin_logs" do
    it "exercises before_remove_for_account_choice_skin_logs somehow" do
      subject.before_remove_for_account_choice_skin_logs 
    end
  end
  context "before_remove_for_account_choice_skin_logs=" do
    it "exercises before_remove_for_account_choice_skin_logs= somehow" do
      subject.before_remove_for_account_choice_skin_logs= 1
    end
  end
  context "before_remove_for_account_choice_skin_logs?" do
    it "exercises before_remove_for_account_choice_skin_logs? somehow" do
      subject.before_remove_for_account_choice_skin_logs? 
    end
  end
  context "before_remove_for_activities" do
    it "exercises before_remove_for_activities somehow" do
      subject.before_remove_for_activities 
    end
  end
  context "before_remove_for_activities=" do
    it "exercises before_remove_for_activities= somehow" do
      subject.before_remove_for_activities= 1
    end
  end
  context "before_remove_for_activities?" do
    it "exercises before_remove_for_activities? somehow" do
      subject.before_remove_for_activities? 
    end
  end
  context "before_remove_for_addresses" do
    it "exercises before_remove_for_addresses somehow" do
      subject.before_remove_for_addresses 
    end
  end
  context "before_remove_for_addresses=" do
    it "exercises before_remove_for_addresses= somehow" do
      subject.before_remove_for_addresses= 1
    end
  end
  context "before_remove_for_addresses?" do
    it "exercises before_remove_for_addresses? somehow" do
      subject.before_remove_for_addresses? 
    end
  end
  context "before_remove_for_comments" do
    it "exercises before_remove_for_comments somehow" do
      subject.before_remove_for_comments 
    end
  end
  context "before_remove_for_comments=" do
    it "exercises before_remove_for_comments= somehow" do
      subject.before_remove_for_comments= 1
    end
  end
  context "before_remove_for_comments?" do
    it "exercises before_remove_for_comments? somehow" do
      subject.before_remove_for_comments? 
    end
  end
  context "before_remove_for_customer_chats" do
    it "exercises before_remove_for_customer_chats somehow" do
      subject.before_remove_for_customer_chats 
    end
  end
  context "before_remove_for_customer_chats=" do
    it "exercises before_remove_for_customer_chats= somehow" do
      subject.before_remove_for_customer_chats= 1
    end
  end
  context "before_remove_for_customer_chats?" do
    it "exercises before_remove_for_customer_chats? somehow" do
      subject.before_remove_for_customer_chats? 
    end
  end
  context "before_remove_for_customer_favourite_products" do
    it "exercises before_remove_for_customer_favourite_products somehow" do
      subject.before_remove_for_customer_favourite_products 
    end
  end
  context "before_remove_for_customer_favourite_products=" do
    it "exercises before_remove_for_customer_favourite_products= somehow" do
      subject.before_remove_for_customer_favourite_products= 1
    end
  end
  context "before_remove_for_customer_favourite_products?" do
    it "exercises before_remove_for_customer_favourite_products? somehow" do
      subject.before_remove_for_customer_favourite_products? 
    end
  end
  context "before_remove_for_customer_skin_journeys" do
    it "exercises before_remove_for_customer_skin_journeys somehow" do
      subject.before_remove_for_customer_skin_journeys 
    end
  end
  context "before_remove_for_customer_skin_journeys=" do
    it "exercises before_remove_for_customer_skin_journeys= somehow" do
      subject.before_remove_for_customer_skin_journeys= 1
    end
  end
  context "before_remove_for_customer_skin_journeys?" do
    it "exercises before_remove_for_customer_skin_journeys? somehow" do
      subject.before_remove_for_customer_skin_journeys? 
    end
  end
  context "before_remove_for_home_page_view" do
    it "exercises before_remove_for_home_page_view somehow" do
      subject.before_remove_for_home_page_view 
    end
  end
  context "before_remove_for_home_page_view=" do
    it "exercises before_remove_for_home_page_view= somehow" do
      subject.before_remove_for_home_page_view= 1
    end
  end
  context "before_remove_for_home_page_view?" do
    it "exercises before_remove_for_home_page_view? somehow" do
      subject.before_remove_for_home_page_view? 
    end
  end
  context "before_remove_for_likes" do
    it "exercises before_remove_for_likes somehow" do
      subject.before_remove_for_likes 
    end
  end
  context "before_remove_for_likes=" do
    it "exercises before_remove_for_likes= somehow" do
      subject.before_remove_for_likes= 1
    end
  end
  context "before_remove_for_likes?" do
    it "exercises before_remove_for_likes? somehow" do
      subject.before_remove_for_likes? 
    end
  end
  context "before_remove_for_messages" do
    it "exercises before_remove_for_messages somehow" do
      subject.before_remove_for_messages 
    end
  end
  context "before_remove_for_messages=" do
    it "exercises before_remove_for_messages= somehow" do
      subject.before_remove_for_messages= 1
    end
  end
  context "before_remove_for_messages?" do
    it "exercises before_remove_for_messages? somehow" do
      subject.before_remove_for_messages? 
    end
  end
  context "before_remove_for_notifications" do
    it "exercises before_remove_for_notifications somehow" do
      subject.before_remove_for_notifications 
    end
  end
  context "before_remove_for_notifications=" do
    it "exercises before_remove_for_notifications= somehow" do
      subject.before_remove_for_notifications= 1
    end
  end
  context "before_remove_for_notifications?" do
    it "exercises before_remove_for_notifications? somehow" do
      subject.before_remove_for_notifications? 
    end
  end
  context "before_remove_for_page_clicks" do
    it "exercises before_remove_for_page_clicks somehow" do
      subject.before_remove_for_page_clicks 
    end
  end
  context "before_remove_for_page_clicks=" do
    it "exercises before_remove_for_page_clicks= somehow" do
      subject.before_remove_for_page_clicks= 1
    end
  end
  context "before_remove_for_page_clicks?" do
    it "exercises before_remove_for_page_clicks? somehow" do
      subject.before_remove_for_page_clicks? 
    end
  end
  context "before_remove_for_product_collection_views" do
    it "exercises before_remove_for_product_collection_views somehow" do
      subject.before_remove_for_product_collection_views 
    end
  end
  context "before_remove_for_product_collection_views=" do
    it "exercises before_remove_for_product_collection_views= somehow" do
      subject.before_remove_for_product_collection_views= 1
    end
  end
  context "before_remove_for_product_collection_views?" do
    it "exercises before_remove_for_product_collection_views? somehow" do
      subject.before_remove_for_product_collection_views? 
    end
  end
  context "before_remove_for_questions" do
    it "exercises before_remove_for_questions somehow" do
      subject.before_remove_for_questions 
    end
  end
  context "before_remove_for_questions=" do
    it "exercises before_remove_for_questions= somehow" do
      subject.before_remove_for_questions= 1
    end
  end
  context "before_remove_for_questions?" do
    it "exercises before_remove_for_questions? somehow" do
      subject.before_remove_for_questions? 
    end
  end
  context "before_remove_for_recommended_product" do
    it "exercises before_remove_for_recommended_product somehow" do
      subject.before_remove_for_recommended_product 
    end
  end
  context "before_remove_for_recommended_product=" do
    it "exercises before_remove_for_recommended_product= somehow" do
      subject.before_remove_for_recommended_product= 1
    end
  end
  context "before_remove_for_recommended_product?" do
    it "exercises before_remove_for_recommended_product? somehow" do
      subject.before_remove_for_recommended_product? 
    end
  end
  context "before_remove_for_recommended_products" do
    it "exercises before_remove_for_recommended_products somehow" do
      subject.before_remove_for_recommended_products 
    end
  end
  context "before_remove_for_recommended_products=" do
    it "exercises before_remove_for_recommended_products= somehow" do
      subject.before_remove_for_recommended_products= 1
    end
  end
  context "before_remove_for_recommended_products?" do
    it "exercises before_remove_for_recommended_products? somehow" do
      subject.before_remove_for_recommended_products? 
    end
  end
  context "before_remove_for_reports" do
    it "exercises before_remove_for_reports somehow" do
      subject.before_remove_for_reports 
    end
  end
  context "before_remove_for_reports=" do
    it "exercises before_remove_for_reports= somehow" do
      subject.before_remove_for_reports= 1
    end
  end
  context "before_remove_for_reports?" do
    it "exercises before_remove_for_reports? somehow" do
      subject.before_remove_for_reports? 
    end
  end
  context "before_remove_for_saved" do
    it "exercises before_remove_for_saved somehow" do
      subject.before_remove_for_saved 
    end
  end
  context "before_remove_for_saved=" do
    it "exercises before_remove_for_saved= somehow" do
      subject.before_remove_for_saved= 1
    end
  end
  context "before_remove_for_saved?" do
    it "exercises before_remove_for_saved? somehow" do
      subject.before_remove_for_saved? 
    end
  end
  context "before_remove_for_skin_log_choices" do
    it "exercises before_remove_for_skin_log_choices somehow" do
      subject.before_remove_for_skin_log_choices 
    end
  end
  context "before_remove_for_skin_log_choices=" do
    it "exercises before_remove_for_skin_log_choices= somehow" do
      subject.before_remove_for_skin_log_choices= 1
    end
  end
  context "before_remove_for_skin_log_choices?" do
    it "exercises before_remove_for_skin_log_choices? somehow" do
      subject.before_remove_for_skin_log_choices? 
    end
  end
  context "before_remove_for_skincare_routine" do
    it "exercises before_remove_for_skincare_routine somehow" do
      subject.before_remove_for_skincare_routine 
    end
  end
  context "before_remove_for_skincare_routine=" do
    it "exercises before_remove_for_skincare_routine= somehow" do
      subject.before_remove_for_skincare_routine= 1
    end
  end
  context "before_remove_for_skincare_routine?" do
    it "exercises before_remove_for_skincare_routine? somehow" do
      subject.before_remove_for_skincare_routine? 
    end
  end
  context "before_remove_for_skincare_routines" do
    it "exercises before_remove_for_skincare_routines somehow" do
      subject.before_remove_for_skincare_routines 
    end
  end
  context "before_remove_for_skincare_routines=" do
    it "exercises before_remove_for_skincare_routines= somehow" do
      subject.before_remove_for_skincare_routines= 1
    end
  end
  context "before_remove_for_skincare_routines?" do
    it "exercises before_remove_for_skincare_routines? somehow" do
      subject.before_remove_for_skincare_routines? 
    end
  end
  context "before_remove_for_stories" do
    it "exercises before_remove_for_stories somehow" do
      subject.before_remove_for_stories 
    end
  end
  context "before_remove_for_stories=" do
    it "exercises before_remove_for_stories= somehow" do
      subject.before_remove_for_stories= 1
    end
  end
  context "before_remove_for_stories?" do
    it "exercises before_remove_for_stories? somehow" do
      subject.before_remove_for_stories? 
    end
  end
  context "before_remove_for_story_views" do
    it "exercises before_remove_for_story_views somehow" do
      subject.before_remove_for_story_views 
    end
  end
  context "before_remove_for_story_views=" do
    it "exercises before_remove_for_story_views= somehow" do
      subject.before_remove_for_story_views= 1
    end
  end
  context "before_remove_for_story_views?" do
    it "exercises before_remove_for_story_views? somehow" do
      subject.before_remove_for_story_views? 
    end
  end
  context "before_remove_for_therapist_notes" do
    it "exercises before_remove_for_therapist_notes somehow" do
      subject.before_remove_for_therapist_notes 
    end
  end
  context "before_remove_for_therapist_notes=" do
    it "exercises before_remove_for_therapist_notes= somehow" do
      subject.before_remove_for_therapist_notes= 1
    end
  end
  context "before_remove_for_therapist_notes?" do
    it "exercises before_remove_for_therapist_notes? somehow" do
      subject.before_remove_for_therapist_notes? 
    end
  end
  context "before_remove_for_tutorial_likes" do
    it "exercises before_remove_for_tutorial_likes somehow" do
      subject.before_remove_for_tutorial_likes 
    end
  end
  context "before_remove_for_tutorial_likes=" do
    it "exercises before_remove_for_tutorial_likes= somehow" do
      subject.before_remove_for_tutorial_likes= 1
    end
  end
  context "before_remove_for_tutorial_likes?" do
    it "exercises before_remove_for_tutorial_likes? somehow" do
      subject.before_remove_for_tutorial_likes? 
    end
  end
  context "before_remove_for_user_images" do
    it "exercises before_remove_for_user_images somehow" do
      subject.before_remove_for_user_images 
    end
  end
  context "before_remove_for_user_images=" do
    it "exercises before_remove_for_user_images= somehow" do
      subject.before_remove_for_user_images= 1
    end
  end
  context "before_remove_for_user_images?" do
    it "exercises before_remove_for_user_images? somehow" do
      subject.before_remove_for_user_images? 
    end
  end
  context "before_remove_for_video_likes" do
    it "exercises before_remove_for_video_likes somehow" do
      subject.before_remove_for_video_likes 
    end
  end
  context "before_remove_for_video_likes=" do
    it "exercises before_remove_for_video_likes= somehow" do
      subject.before_remove_for_video_likes= 1
    end
  end
  context "before_remove_for_video_likes?" do
    it "exercises before_remove_for_video_likes? somehow" do
      subject.before_remove_for_video_likes? 
    end
  end
  context "before_remove_for_views" do
    it "exercises before_remove_for_views somehow" do
      subject.before_remove_for_views 
    end
  end
  context "before_remove_for_views=" do
    it "exercises before_remove_for_views= somehow" do
      subject.before_remove_for_views= 1
    end
  end
  context "before_remove_for_views?" do
    it "exercises before_remove_for_views? somehow" do
      subject.before_remove_for_views? 
    end
  end
  context "current_password" do
    it "exercises current_password somehow" do
      subject.current_password 
    end
  end
  context "devise_modules" do
    it "exercises devise_modules somehow" do
      subject.devise_modules 
    end
  end
  context "devise_modules?" do
    it "exercises devise_modules? somehow" do
      subject.devise_modules? 
    end
  end
  context "membership_plan" do
    it "exercises membership_plan somehow" do
      subject.membership_plan 
    end
  end
  context "name" do
    it "exercises name somehow" do
      subject.name 
    end
  end
  context "password" do
    it "exercises password somehow" do
      subject.password 
    end
  end
  context "password_confirmation" do
    it "exercises password_confirmation somehow" do
      subject.password_confirmation 
    end
  end
  context "password_confirmation=" do
    it "exercises password_confirmation= somehow" do
      subject.password_confirmation= 1
    end
  end
  context "profile_pic_attachment_id" do
    it "exercises profile_pic_attachment_id somehow" do
      subject.profile_pic_attachment_id 
    end
  end
  context "profile_pic_blob_id" do
    it "exercises profile_pic_blob_id somehow" do
      subject.profile_pic_blob_id 
    end
  end
  context "type" do
    it "exercises type somehow" do
      subject.type 
    end
  end
  context "unique_email" do
    it "exercises unique_email somehow" do
      subject.unique_email 
    end
  end
  context "validate_associated_records_for_account_choice_skin_logs" do
    it "exercises validate_associated_records_for_account_choice_skin_logs somehow" do
      subject.validate_associated_records_for_account_choice_skin_logs 
    end
  end
  context "validate_associated_records_for_activities" do
    it "exercises validate_associated_records_for_activities somehow" do
      subject.validate_associated_records_for_activities 
    end
  end
  context "validate_associated_records_for_addresses" do
    it "exercises validate_associated_records_for_addresses somehow" do
      subject.validate_associated_records_for_addresses 
    end
  end
  context "validate_associated_records_for_comments" do
    it "exercises validate_associated_records_for_comments somehow" do
      subject.validate_associated_records_for_comments 
    end
  end
  context "validate_associated_records_for_customer_chats" do
    it "exercises validate_associated_records_for_customer_chats somehow" do
      subject.validate_associated_records_for_customer_chats 
    end
  end
  context "validate_associated_records_for_customer_favourite_products" do
    it "exercises validate_associated_records_for_customer_favourite_products somehow" do
      subject.validate_associated_records_for_customer_favourite_products 
    end
  end
  context "validate_associated_records_for_customer_skin_journeys" do
    it "exercises validate_associated_records_for_customer_skin_journeys somehow" do
      subject.validate_associated_records_for_customer_skin_journeys 
    end
  end
  context "validate_associated_records_for_home_page_view" do
    it "exercises validate_associated_records_for_home_page_view somehow" do
      subject.validate_associated_records_for_home_page_view 
    end
  end
  context "validate_associated_records_for_likes" do
    it "exercises validate_associated_records_for_likes somehow" do
      subject.validate_associated_records_for_likes 
    end
  end
  context "validate_associated_records_for_messages" do
    it "exercises validate_associated_records_for_messages somehow" do
      subject.validate_associated_records_for_messages 
    end
  end
  context "validate_associated_records_for_notifications" do
    it "exercises validate_associated_records_for_notifications somehow" do
      subject.validate_associated_records_for_notifications 
    end
  end
  context "validate_associated_records_for_page_clicks" do
    it "exercises validate_associated_records_for_page_clicks somehow" do
      subject.validate_associated_records_for_page_clicks 
    end
  end
  context "validate_associated_records_for_product_collection_views" do
    it "exercises validate_associated_records_for_product_collection_views somehow" do
      subject.validate_associated_records_for_product_collection_views 
    end
  end
  context "validate_associated_records_for_questions" do
    it "exercises validate_associated_records_for_questions somehow" do
      subject.validate_associated_records_for_questions 
    end
  end
  context "validate_associated_records_for_recommended_product" do
    it "exercises validate_associated_records_for_recommended_product somehow" do
      subject.validate_associated_records_for_recommended_product 
    end
  end
  context "validate_associated_records_for_recommended_products" do
    it "exercises validate_associated_records_for_recommended_products somehow" do
      subject.validate_associated_records_for_recommended_products 
    end
  end
  context "validate_associated_records_for_reports" do
    it "exercises validate_associated_records_for_reports somehow" do
      subject.validate_associated_records_for_reports 
    end
  end
  context "validate_associated_records_for_saved" do
    it "exercises validate_associated_records_for_saved somehow" do
      subject.validate_associated_records_for_saved 
    end
  end
  context "validate_associated_records_for_skin_log_choices" do
    it "exercises validate_associated_records_for_skin_log_choices somehow" do
      subject.validate_associated_records_for_skin_log_choices 
    end
  end
  context "validate_associated_records_for_skincare_routine" do
    it "exercises validate_associated_records_for_skincare_routine somehow" do
      subject.validate_associated_records_for_skincare_routine 
    end
  end
  context "validate_associated_records_for_skincare_routines" do
    it "exercises validate_associated_records_for_skincare_routines somehow" do
      subject.validate_associated_records_for_skincare_routines 
    end
  end
  context "validate_associated_records_for_stories" do
    it "exercises validate_associated_records_for_stories somehow" do
      subject.validate_associated_records_for_stories 
    end
  end
  context "validate_associated_records_for_story_views" do
    it "exercises validate_associated_records_for_story_views somehow" do
      subject.validate_associated_records_for_story_views 
    end
  end
  context "validate_associated_records_for_therapist_notes" do
    it "exercises validate_associated_records_for_therapist_notes somehow" do
      subject.validate_associated_records_for_therapist_notes 
    end
  end
  context "validate_associated_records_for_tutorial_likes" do
    it "exercises validate_associated_records_for_tutorial_likes somehow" do
      subject.validate_associated_records_for_tutorial_likes 
    end
  end
  context "validate_associated_records_for_user_images" do
    it "exercises validate_associated_records_for_user_images somehow" do
      subject.validate_associated_records_for_user_images 
    end
  end
  context "validate_associated_records_for_video_likes" do
    it "exercises validate_associated_records_for_video_likes somehow" do
      subject.validate_associated_records_for_video_likes 
    end
  end
  context "validate_associated_records_for_views" do
    it "exercises validate_associated_records_for_views somehow" do
      subject.validate_associated_records_for_views 
    end
  end

end
