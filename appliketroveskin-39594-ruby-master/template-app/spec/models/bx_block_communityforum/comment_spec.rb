require 'rails_helper'

describe BxBlockCommunityforum::Comment, :type => :model do
  # let (:subject) { build :bx_block_communityforum/comment }
  # context "validation" do
  #   it { should validate_presence_of :objectable }
  #   it { should validate_presence_of :accountable }
  # end
  context "associations" do
    it { should belong_to :objectable }
    it { should belong_to :accountable }
    it { should have_many :likes }
    it { should have_many :comments }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
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
  context "autosave_associated_records_for_likes" do
    it "exercises autosave_associated_records_for_likes somehow" do
      subject.autosave_associated_records_for_likes 
    end
  end
  context "autosave_associated_records_for_objectable" do
    it "exercises autosave_associated_records_for_objectable somehow" do
      subject.autosave_associated_records_for_objectable 
    end
  end
  context "autosave_associated_records_for_reports" do
    it "exercises autosave_associated_records_for_reports somehow" do
      subject.autosave_associated_records_for_reports 
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
  # context "create_mentions" do
  #   it "exercises create_mentions somehow" do
  #     subject.create_mentions 
  #   end
  # end
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
  # context "log_activity" do
  #   it "exercises log_activity somehow" do
  #     subject.log_activity 
  #   end
  # end
  context "remove_activity" do
    it "exercises remove_activity somehow" do
      subject.remove_activity 
    end
  end
  # context "remove_if_offensive" do
  #   it "exercises remove_if_offensive somehow" do
  #     subject.remove_if_offensive 
  #   end
  # end
  context "validate_associated_records_for_comments" do
    it "exercises validate_associated_records_for_comments somehow" do
      subject.validate_associated_records_for_comments 
    end
  end
  context "validate_associated_records_for_likes" do
    it "exercises validate_associated_records_for_likes somehow" do
      subject.validate_associated_records_for_likes 
    end
  end
  context "validate_associated_records_for_reports" do
    it "exercises validate_associated_records_for_reports somehow" do
      subject.validate_associated_records_for_reports 
    end
  end

end
