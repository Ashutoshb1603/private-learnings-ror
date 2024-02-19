require 'rails_helper'

describe BxBlockContentmanagement::LiveVideo, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/live_video }
  context "validation" do
  end
  context "associations" do
    it { should have_many :videos_attachments }
    it { should have_many :videos_blobs }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
    it { should have_many :video_views }
    it { should have_many :video_likes }
    # it { should belong_to :group }
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
  context "after_add_for_video_views" do
    it "exercises after_add_for_video_views somehow" do
      subject.after_add_for_video_views 
    end
  end
  context "after_add_for_video_views=" do
    it "exercises after_add_for_video_views= somehow" do
      subject.after_add_for_video_views= 1
    end
  end
  context "after_add_for_video_views?" do
    it "exercises after_add_for_video_views? somehow" do
      subject.after_add_for_video_views? 
    end
  end
  context "after_add_for_videos_attachments" do
    it "exercises after_add_for_videos_attachments somehow" do
      subject.after_add_for_videos_attachments 
    end
  end
  context "after_add_for_videos_attachments=" do
    it "exercises after_add_for_videos_attachments= somehow" do
      subject.after_add_for_videos_attachments= 1
    end
  end
  context "after_add_for_videos_attachments?" do
    it "exercises after_add_for_videos_attachments? somehow" do
      subject.after_add_for_videos_attachments? 
    end
  end
  context "after_add_for_videos_blobs" do
    it "exercises after_add_for_videos_blobs somehow" do
      subject.after_add_for_videos_blobs 
    end
  end
  context "after_add_for_videos_blobs=" do
    it "exercises after_add_for_videos_blobs= somehow" do
      subject.after_add_for_videos_blobs= 1
    end
  end
  context "after_add_for_videos_blobs?" do
    it "exercises after_add_for_videos_blobs? somehow" do
      subject.after_add_for_videos_blobs? 
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
  context "after_remove_for_video_views" do
    it "exercises after_remove_for_video_views somehow" do
      subject.after_remove_for_video_views 
    end
  end
  context "after_remove_for_video_views=" do
    it "exercises after_remove_for_video_views= somehow" do
      subject.after_remove_for_video_views= 1
    end
  end
  context "after_remove_for_video_views?" do
    it "exercises after_remove_for_video_views? somehow" do
      subject.after_remove_for_video_views? 
    end
  end
  context "after_remove_for_videos_attachments" do
    it "exercises after_remove_for_videos_attachments somehow" do
      subject.after_remove_for_videos_attachments 
    end
  end
  context "after_remove_for_videos_attachments=" do
    it "exercises after_remove_for_videos_attachments= somehow" do
      subject.after_remove_for_videos_attachments= 1
    end
  end
  context "after_remove_for_videos_attachments?" do
    it "exercises after_remove_for_videos_attachments? somehow" do
      subject.after_remove_for_videos_attachments? 
    end
  end
  context "after_remove_for_videos_blobs" do
    it "exercises after_remove_for_videos_blobs somehow" do
      subject.after_remove_for_videos_blobs 
    end
  end
  context "after_remove_for_videos_blobs=" do
    it "exercises after_remove_for_videos_blobs= somehow" do
      subject.after_remove_for_videos_blobs= 1
    end
  end
  context "after_remove_for_videos_blobs?" do
    it "exercises after_remove_for_videos_blobs? somehow" do
      subject.after_remove_for_videos_blobs? 
    end
  end
  context "autosave_associated_records_for_group" do
    it "exercises autosave_associated_records_for_group somehow" do
      subject.autosave_associated_records_for_group 
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
  context "autosave_associated_records_for_video_likes" do
    it "exercises autosave_associated_records_for_video_likes somehow" do
      subject.autosave_associated_records_for_video_likes 
    end
  end
  context "autosave_associated_records_for_video_views" do
    it "exercises autosave_associated_records_for_video_views somehow" do
      subject.autosave_associated_records_for_video_views 
    end
  end
  context "autosave_associated_records_for_videos_attachments" do
    it "exercises autosave_associated_records_for_videos_attachments somehow" do
      subject.autosave_associated_records_for_videos_attachments 
    end
  end
  context "autosave_associated_records_for_videos_blobs" do
    it "exercises autosave_associated_records_for_videos_blobs somehow" do
      subject.autosave_associated_records_for_videos_blobs 
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
  context "before_add_for_video_views" do
    it "exercises before_add_for_video_views somehow" do
      subject.before_add_for_video_views 
    end
  end
  context "before_add_for_video_views=" do
    it "exercises before_add_for_video_views= somehow" do
      subject.before_add_for_video_views= 1
    end
  end
  context "before_add_for_video_views?" do
    it "exercises before_add_for_video_views? somehow" do
      subject.before_add_for_video_views? 
    end
  end
  context "before_add_for_videos_attachments" do
    it "exercises before_add_for_videos_attachments somehow" do
      subject.before_add_for_videos_attachments 
    end
  end
  context "before_add_for_videos_attachments=" do
    it "exercises before_add_for_videos_attachments= somehow" do
      subject.before_add_for_videos_attachments= 1
    end
  end
  context "before_add_for_videos_attachments?" do
    it "exercises before_add_for_videos_attachments? somehow" do
      subject.before_add_for_videos_attachments? 
    end
  end
  context "before_add_for_videos_blobs" do
    it "exercises before_add_for_videos_blobs somehow" do
      subject.before_add_for_videos_blobs 
    end
  end
  context "before_add_for_videos_blobs=" do
    it "exercises before_add_for_videos_blobs= somehow" do
      subject.before_add_for_videos_blobs= 1
    end
  end
  context "before_add_for_videos_blobs?" do
    it "exercises before_add_for_videos_blobs? somehow" do
      subject.before_add_for_videos_blobs? 
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
  context "before_remove_for_video_views" do
    it "exercises before_remove_for_video_views somehow" do
      subject.before_remove_for_video_views 
    end
  end
  context "before_remove_for_video_views=" do
    it "exercises before_remove_for_video_views= somehow" do
      subject.before_remove_for_video_views= 1
    end
  end
  context "before_remove_for_video_views?" do
    it "exercises before_remove_for_video_views? somehow" do
      subject.before_remove_for_video_views? 
    end
  end
  context "before_remove_for_videos_attachments" do
    it "exercises before_remove_for_videos_attachments somehow" do
      subject.before_remove_for_videos_attachments 
    end
  end
  context "before_remove_for_videos_attachments=" do
    it "exercises before_remove_for_videos_attachments= somehow" do
      subject.before_remove_for_videos_attachments= 1
    end
  end
  context "before_remove_for_videos_attachments?" do
    it "exercises before_remove_for_videos_attachments? somehow" do
      subject.before_remove_for_videos_attachments? 
    end
  end
  context "before_remove_for_videos_blobs" do
    it "exercises before_remove_for_videos_blobs somehow" do
      subject.before_remove_for_videos_blobs 
    end
  end
  context "before_remove_for_videos_blobs=" do
    it "exercises before_remove_for_videos_blobs= somehow" do
      subject.before_remove_for_videos_blobs= 1
    end
  end
  context "before_remove_for_videos_blobs?" do
    it "exercises before_remove_for_videos_blobs? somehow" do
      subject.before_remove_for_videos_blobs? 
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
  context "validate_associated_records_for_video_likes" do
    it "exercises validate_associated_records_for_video_likes somehow" do
      subject.validate_associated_records_for_video_likes 
    end
  end
  context "validate_associated_records_for_video_views" do
    it "exercises validate_associated_records_for_video_views somehow" do
      subject.validate_associated_records_for_video_views 
    end
  end
  context "validate_associated_records_for_videos_attachments" do
    it "exercises validate_associated_records_for_videos_attachments somehow" do
      subject.validate_associated_records_for_videos_attachments 
    end
  end
  context "validate_associated_records_for_videos_blobs" do
    it "exercises validate_associated_records_for_videos_blobs somehow" do
      subject.validate_associated_records_for_videos_blobs 
    end
  end

end
