require 'rails_helper'

describe BxBlockCommunityforum::Question, :type => :model do
  # let (:subject) { build :bx_block_communityforum/question }
  # context "validation" do
  #   it { should validate_presence_of :accountable }
  # end
  context "associations" do
    it { should have_many :question_tags }
    it { should have_many :groups }
    it { should have_many :saved }
    it { should have_many :comments }
    it { should have_many :likes }
    it { should have_many :views }
    it { should belong_to :accountable }
    it { should have_many :images_attachments }
    it { should have_many :images_blobs }
    it { should have_many :reports }
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
  context "after_add_for_groups" do
    it "exercises after_add_for_groups somehow" do
      subject.after_add_for_groups 
    end
  end
  context "after_add_for_groups=" do
    it "exercises after_add_for_groups= somehow" do
      subject.after_add_for_groups= 1
    end
  end
  context "after_add_for_groups?" do
    it "exercises after_add_for_groups? somehow" do
      subject.after_add_for_groups? 
    end
  end
  context "after_add_for_images_attachments" do
    it "exercises after_add_for_images_attachments somehow" do
      subject.after_add_for_images_attachments 
    end
  end
  context "after_add_for_images_attachments=" do
    it "exercises after_add_for_images_attachments= somehow" do
      subject.after_add_for_images_attachments= 1
    end
  end
  context "after_add_for_images_attachments?" do
    it "exercises after_add_for_images_attachments? somehow" do
      subject.after_add_for_images_attachments? 
    end
  end
  context "after_add_for_images_blobs" do
    it "exercises after_add_for_images_blobs somehow" do
      subject.after_add_for_images_blobs 
    end
  end
  context "after_add_for_images_blobs=" do
    it "exercises after_add_for_images_blobs= somehow" do
      subject.after_add_for_images_blobs= 1
    end
  end
  context "after_add_for_images_blobs?" do
    it "exercises after_add_for_images_blobs? somehow" do
      subject.after_add_for_images_blobs? 
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
  context "after_add_for_question_tags" do
    it "exercises after_add_for_question_tags somehow" do
      subject.after_add_for_question_tags 
    end
  end
  context "after_add_for_question_tags=" do
    it "exercises after_add_for_question_tags= somehow" do
      subject.after_add_for_question_tags= 1
    end
  end
  context "after_add_for_question_tags?" do
    it "exercises after_add_for_question_tags? somehow" do
      subject.after_add_for_question_tags? 
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
  context "after_remove_for_groups" do
    it "exercises after_remove_for_groups somehow" do
      subject.after_remove_for_groups 
    end
  end
  context "after_remove_for_groups=" do
    it "exercises after_remove_for_groups= somehow" do
      subject.after_remove_for_groups= 1
    end
  end
  context "after_remove_for_groups?" do
    it "exercises after_remove_for_groups? somehow" do
      subject.after_remove_for_groups? 
    end
  end
  context "after_remove_for_images_attachments" do
    it "exercises after_remove_for_images_attachments somehow" do
      subject.after_remove_for_images_attachments 
    end
  end
  context "after_remove_for_images_attachments=" do
    it "exercises after_remove_for_images_attachments= somehow" do
      subject.after_remove_for_images_attachments= 1
    end
  end
  context "after_remove_for_images_attachments?" do
    it "exercises after_remove_for_images_attachments? somehow" do
      subject.after_remove_for_images_attachments? 
    end
  end
  context "after_remove_for_images_blobs" do
    it "exercises after_remove_for_images_blobs somehow" do
      subject.after_remove_for_images_blobs 
    end
  end
  context "after_remove_for_images_blobs=" do
    it "exercises after_remove_for_images_blobs= somehow" do
      subject.after_remove_for_images_blobs= 1
    end
  end
  context "after_remove_for_images_blobs?" do
    it "exercises after_remove_for_images_blobs? somehow" do
      subject.after_remove_for_images_blobs? 
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
  context "after_remove_for_question_tags" do
    it "exercises after_remove_for_question_tags somehow" do
      subject.after_remove_for_question_tags 
    end
  end
  context "after_remove_for_question_tags=" do
    it "exercises after_remove_for_question_tags= somehow" do
      subject.after_remove_for_question_tags= 1
    end
  end
  context "after_remove_for_question_tags?" do
    it "exercises after_remove_for_question_tags? somehow" do
      subject.after_remove_for_question_tags? 
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
  context "autosave_associated_records_for_accountable" do
    it "exercises autosave_associated_records_for_accountable somehow" do
      subject.autosave_associated_records_for_accountable 
    end
  end
  context "autosave_associated_records_for_comments" do
    it "exercises autosave_associated_records_for_comments somehow" do
      subject.autosave_associated_records_for_comments 
    end
  end
  context "autosave_associated_records_for_groups" do
    it "exercises autosave_associated_records_for_groups somehow" do
      subject.autosave_associated_records_for_groups 
    end
  end
  context "autosave_associated_records_for_images_attachments" do
    it "exercises autosave_associated_records_for_images_attachments somehow" do
      subject.autosave_associated_records_for_images_attachments 
    end
  end
  context "autosave_associated_records_for_images_blobs" do
    it "exercises autosave_associated_records_for_images_blobs somehow" do
      subject.autosave_associated_records_for_images_blobs 
    end
  end
  context "autosave_associated_records_for_likes" do
    it "exercises autosave_associated_records_for_likes somehow" do
      subject.autosave_associated_records_for_likes 
    end
  end
  context "autosave_associated_records_for_question_tags" do
    it "exercises autosave_associated_records_for_question_tags somehow" do
      subject.autosave_associated_records_for_question_tags 
    end
  end
  context "autosave_associated_records_for_reports" do
    it "exercises autosave_associated_records_for_reports somehow" do
      subject.autosave_associated_records_for_reports 
    end
  end
  context "autosave_associated_records_for_saved" do
    it "exercises autosave_associated_records_for_saved somehow" do
      subject.autosave_associated_records_for_saved 
    end
  end
  context "autosave_associated_records_for_views" do
    it "exercises autosave_associated_records_for_views somehow" do
      subject.autosave_associated_records_for_views 
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
  context "before_add_for_groups" do
    it "exercises before_add_for_groups somehow" do
      subject.before_add_for_groups 
    end
  end
  context "before_add_for_groups=" do
    it "exercises before_add_for_groups= somehow" do
      subject.before_add_for_groups= 1
    end
  end
  context "before_add_for_groups?" do
    it "exercises before_add_for_groups? somehow" do
      subject.before_add_for_groups? 
    end
  end
  context "before_add_for_images_attachments" do
    it "exercises before_add_for_images_attachments somehow" do
      subject.before_add_for_images_attachments 
    end
  end
  context "before_add_for_images_attachments=" do
    it "exercises before_add_for_images_attachments= somehow" do
      subject.before_add_for_images_attachments= 1
    end
  end
  context "before_add_for_images_attachments?" do
    it "exercises before_add_for_images_attachments? somehow" do
      subject.before_add_for_images_attachments? 
    end
  end
  context "before_add_for_images_blobs" do
    it "exercises before_add_for_images_blobs somehow" do
      subject.before_add_for_images_blobs 
    end
  end
  context "before_add_for_images_blobs=" do
    it "exercises before_add_for_images_blobs= somehow" do
      subject.before_add_for_images_blobs= 1
    end
  end
  context "before_add_for_images_blobs?" do
    it "exercises before_add_for_images_blobs? somehow" do
      subject.before_add_for_images_blobs? 
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
  context "before_add_for_question_tags" do
    it "exercises before_add_for_question_tags somehow" do
      subject.before_add_for_question_tags 
    end
  end
  context "before_add_for_question_tags=" do
    it "exercises before_add_for_question_tags= somehow" do
      subject.before_add_for_question_tags= 1
    end
  end
  context "before_add_for_question_tags?" do
    it "exercises before_add_for_question_tags? somehow" do
      subject.before_add_for_question_tags? 
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
  context "before_remove_for_groups" do
    it "exercises before_remove_for_groups somehow" do
      subject.before_remove_for_groups 
    end
  end
  context "before_remove_for_groups=" do
    it "exercises before_remove_for_groups= somehow" do
      subject.before_remove_for_groups= 1
    end
  end
  context "before_remove_for_groups?" do
    it "exercises before_remove_for_groups? somehow" do
      subject.before_remove_for_groups? 
    end
  end
  context "before_remove_for_images_attachments" do
    it "exercises before_remove_for_images_attachments somehow" do
      subject.before_remove_for_images_attachments 
    end
  end
  context "before_remove_for_images_attachments=" do
    it "exercises before_remove_for_images_attachments= somehow" do
      subject.before_remove_for_images_attachments= 1
    end
  end
  context "before_remove_for_images_attachments?" do
    it "exercises before_remove_for_images_attachments? somehow" do
      subject.before_remove_for_images_attachments? 
    end
  end
  context "before_remove_for_images_blobs" do
    it "exercises before_remove_for_images_blobs somehow" do
      subject.before_remove_for_images_blobs 
    end
  end
  context "before_remove_for_images_blobs=" do
    it "exercises before_remove_for_images_blobs= somehow" do
      subject.before_remove_for_images_blobs= 1
    end
  end
  context "before_remove_for_images_blobs?" do
    it "exercises before_remove_for_images_blobs? somehow" do
      subject.before_remove_for_images_blobs? 
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
  context "before_remove_for_question_tags" do
    it "exercises before_remove_for_question_tags somehow" do
      subject.before_remove_for_question_tags 
    end
  end
  context "before_remove_for_question_tags=" do
    it "exercises before_remove_for_question_tags= somehow" do
      subject.before_remove_for_question_tags= 1
    end
  end
  context "before_remove_for_question_tags?" do
    it "exercises before_remove_for_question_tags? somehow" do
      subject.before_remove_for_question_tags? 
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
  # context "remove_if_offensive" do
  #   it "exercises remove_if_offensive somehow" do
  #     subject.remove_if_offensive 
  #   end
  # end
  # context "set_user_type" do
  #   it "exercises set_user_type somehow" do
  #     subject.set_user_type 
  #   end
  # end
  context "validate_associated_records_for_comments" do
    it "exercises validate_associated_records_for_comments somehow" do
      subject.validate_associated_records_for_comments 
    end
  end
  context "validate_associated_records_for_groups" do
    it "exercises validate_associated_records_for_groups somehow" do
      subject.validate_associated_records_for_groups 
    end
  end
  context "validate_associated_records_for_images_attachments" do
    it "exercises validate_associated_records_for_images_attachments somehow" do
      subject.validate_associated_records_for_images_attachments 
    end
  end
  context "validate_associated_records_for_images_blobs" do
    it "exercises validate_associated_records_for_images_blobs somehow" do
      subject.validate_associated_records_for_images_blobs 
    end
  end
  context "validate_associated_records_for_likes" do
    it "exercises validate_associated_records_for_likes somehow" do
      subject.validate_associated_records_for_likes 
    end
  end
  context "validate_associated_records_for_question_tags" do
    it "exercises validate_associated_records_for_question_tags somehow" do
      subject.validate_associated_records_for_question_tags 
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
  context "validate_associated_records_for_views" do
    it "exercises validate_associated_records_for_views somehow" do
      subject.validate_associated_records_for_views 
    end
  end

end
