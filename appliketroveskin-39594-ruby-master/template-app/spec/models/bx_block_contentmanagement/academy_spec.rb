require 'rails_helper'

describe BxBlockContentmanagement::Academy, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/academy }
  context "validation" do
  end
  context "associations" do
    it { should have_many :academy_videos }
    it { should have_many :customer_academy_subscriptions }
    it { should have_many :key_points }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
  end
  context "after_add_for_academy_videos" do
    it "exercises after_add_for_academy_videos somehow" do
      subject.after_add_for_academy_videos 
    end
  end
  context "after_add_for_academy_videos=" do
    it "exercises after_add_for_academy_videos= somehow" do
      subject.after_add_for_academy_videos= 1
    end
  end
  context "after_add_for_academy_videos?" do
    it "exercises after_add_for_academy_videos? somehow" do
      subject.after_add_for_academy_videos? 
    end
  end
  context "after_add_for_customer_academy_subscriptions" do
    it "exercises after_add_for_customer_academy_subscriptions somehow" do
      subject.after_add_for_customer_academy_subscriptions 
    end
  end
  context "after_add_for_customer_academy_subscriptions=" do
    it "exercises after_add_for_customer_academy_subscriptions= somehow" do
      subject.after_add_for_customer_academy_subscriptions= 1
    end
  end
  context "after_add_for_customer_academy_subscriptions?" do
    it "exercises after_add_for_customer_academy_subscriptions? somehow" do
      subject.after_add_for_customer_academy_subscriptions? 
    end
  end
  context "after_add_for_key_points" do
    it "exercises after_add_for_key_points somehow" do
      subject.after_add_for_key_points 
    end
  end
  context "after_add_for_key_points=" do
    it "exercises after_add_for_key_points= somehow" do
      subject.after_add_for_key_points= 1
    end
  end
  context "after_add_for_key_points?" do
    it "exercises after_add_for_key_points? somehow" do
      subject.after_add_for_key_points? 
    end
  end
  context "after_remove_for_academy_videos" do
    it "exercises after_remove_for_academy_videos somehow" do
      subject.after_remove_for_academy_videos 
    end
  end
  context "after_remove_for_academy_videos=" do
    it "exercises after_remove_for_academy_videos= somehow" do
      subject.after_remove_for_academy_videos= 1
    end
  end
  context "after_remove_for_academy_videos?" do
    it "exercises after_remove_for_academy_videos? somehow" do
      subject.after_remove_for_academy_videos? 
    end
  end
  context "after_remove_for_customer_academy_subscriptions" do
    it "exercises after_remove_for_customer_academy_subscriptions somehow" do
      subject.after_remove_for_customer_academy_subscriptions 
    end
  end
  context "after_remove_for_customer_academy_subscriptions=" do
    it "exercises after_remove_for_customer_academy_subscriptions= somehow" do
      subject.after_remove_for_customer_academy_subscriptions= 1
    end
  end
  context "after_remove_for_customer_academy_subscriptions?" do
    it "exercises after_remove_for_customer_academy_subscriptions? somehow" do
      subject.after_remove_for_customer_academy_subscriptions? 
    end
  end
  context "after_remove_for_key_points" do
    it "exercises after_remove_for_key_points somehow" do
      subject.after_remove_for_key_points 
    end
  end
  context "after_remove_for_key_points=" do
    it "exercises after_remove_for_key_points= somehow" do
      subject.after_remove_for_key_points= 1
    end
  end
  context "after_remove_for_key_points?" do
    it "exercises after_remove_for_key_points? somehow" do
      subject.after_remove_for_key_points? 
    end
  end
  context "autosave_associated_records_for_academy_videos" do
    it "exercises autosave_associated_records_for_academy_videos somehow" do
      subject.autosave_associated_records_for_academy_videos 
    end
  end
  context "autosave_associated_records_for_customer_academy_subscriptions" do
    it "exercises autosave_associated_records_for_customer_academy_subscriptions somehow" do
      subject.autosave_associated_records_for_customer_academy_subscriptions 
    end
  end
  context "autosave_associated_records_for_image_attachment" do
    it "exercises autosave_associated_records_for_image_attachment somehow" do
      subject.autosave_associated_records_for_image_attachment 
    end
  end
  context "autosave_associated_records_for_image_blob" do
    it "exercises autosave_associated_records_for_image_blob somehow" do
      subject.autosave_associated_records_for_image_blob 
    end
  end
  context "autosave_associated_records_for_key_points" do
    it "exercises autosave_associated_records_for_key_points somehow" do
      subject.autosave_associated_records_for_key_points 
    end
  end
  context "before_add_for_academy_videos" do
    it "exercises before_add_for_academy_videos somehow" do
      subject.before_add_for_academy_videos 
    end
  end
  context "before_add_for_academy_videos=" do
    it "exercises before_add_for_academy_videos= somehow" do
      subject.before_add_for_academy_videos= 1
    end
  end
  context "before_add_for_academy_videos?" do
    it "exercises before_add_for_academy_videos? somehow" do
      subject.before_add_for_academy_videos? 
    end
  end
  context "before_add_for_customer_academy_subscriptions" do
    it "exercises before_add_for_customer_academy_subscriptions somehow" do
      subject.before_add_for_customer_academy_subscriptions 
    end
  end
  context "before_add_for_customer_academy_subscriptions=" do
    it "exercises before_add_for_customer_academy_subscriptions= somehow" do
      subject.before_add_for_customer_academy_subscriptions= 1
    end
  end
  context "before_add_for_customer_academy_subscriptions?" do
    it "exercises before_add_for_customer_academy_subscriptions? somehow" do
      subject.before_add_for_customer_academy_subscriptions? 
    end
  end
  context "before_add_for_key_points" do
    it "exercises before_add_for_key_points somehow" do
      subject.before_add_for_key_points 
    end
  end
  context "before_add_for_key_points=" do
    it "exercises before_add_for_key_points= somehow" do
      subject.before_add_for_key_points= 1
    end
  end
  context "before_add_for_key_points?" do
    it "exercises before_add_for_key_points? somehow" do
      subject.before_add_for_key_points? 
    end
  end
  context "before_remove_for_academy_videos" do
    it "exercises before_remove_for_academy_videos somehow" do
      subject.before_remove_for_academy_videos 
    end
  end
  context "before_remove_for_academy_videos=" do
    it "exercises before_remove_for_academy_videos= somehow" do
      subject.before_remove_for_academy_videos= 1
    end
  end
  context "before_remove_for_academy_videos?" do
    it "exercises before_remove_for_academy_videos? somehow" do
      subject.before_remove_for_academy_videos? 
    end
  end
  context "before_remove_for_customer_academy_subscriptions" do
    it "exercises before_remove_for_customer_academy_subscriptions somehow" do
      subject.before_remove_for_customer_academy_subscriptions 
    end
  end
  context "before_remove_for_customer_academy_subscriptions=" do
    it "exercises before_remove_for_customer_academy_subscriptions= somehow" do
      subject.before_remove_for_customer_academy_subscriptions= 1
    end
  end
  context "before_remove_for_customer_academy_subscriptions?" do
    it "exercises before_remove_for_customer_academy_subscriptions? somehow" do
      subject.before_remove_for_customer_academy_subscriptions? 
    end
  end
  context "before_remove_for_key_points" do
    it "exercises before_remove_for_key_points somehow" do
      subject.before_remove_for_key_points 
    end
  end
  context "before_remove_for_key_points=" do
    it "exercises before_remove_for_key_points= somehow" do
      subject.before_remove_for_key_points= 1
    end
  end
  context "before_remove_for_key_points?" do
    it "exercises before_remove_for_key_points? somehow" do
      subject.before_remove_for_key_points? 
    end
  end
  context "image_attachment_id" do
    it "exercises image_attachment_id somehow" do
      subject.image_attachment_id 
    end
  end
  context "image_blob_id" do
    it "exercises image_blob_id somehow" do
      subject.image_blob_id 
    end
  end
  context "send_notification" do
    it "exercises send_notification somehow" do
      subject.send_notification 
    end
  end
  context "validate_associated_records_for_academy_videos" do
    it "exercises validate_associated_records_for_academy_videos somehow" do
      subject.validate_associated_records_for_academy_videos 
    end
  end
  context "validate_associated_records_for_customer_academy_subscriptions" do
    it "exercises validate_associated_records_for_customer_academy_subscriptions somehow" do
      subject.validate_associated_records_for_customer_academy_subscriptions 
    end
  end
  context "validate_associated_records_for_key_points" do
    it "exercises validate_associated_records_for_key_points somehow" do
      subject.validate_associated_records_for_key_points 
    end
  end

end
