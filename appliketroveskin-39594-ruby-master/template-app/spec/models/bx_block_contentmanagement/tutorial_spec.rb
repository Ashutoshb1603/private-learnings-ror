require 'rails_helper'

describe BxBlockContentmanagement::Tutorial, :type => :model do
  # let (:subject) { build :bx_block_contentmanagement/tutorial }
  # context "validation" do
  #   it { should validate_presence_of :group }
  #   it "format_validator test for [:url]"
  # end
  context "associations" do
    it { should have_many :tutorial_views }
    it { should have_many :tutorial_likes }
    it { should belong_to :group }
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
  context "after_add_for_tutorial_views" do
    it "exercises after_add_for_tutorial_views somehow" do
      subject.after_add_for_tutorial_views 
    end
  end
  context "after_add_for_tutorial_views=" do
    it "exercises after_add_for_tutorial_views= somehow" do
      subject.after_add_for_tutorial_views= 1
    end
  end
  context "after_add_for_tutorial_views?" do
    it "exercises after_add_for_tutorial_views? somehow" do
      subject.after_add_for_tutorial_views? 
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
  context "after_remove_for_tutorial_views" do
    it "exercises after_remove_for_tutorial_views somehow" do
      subject.after_remove_for_tutorial_views 
    end
  end
  context "after_remove_for_tutorial_views=" do
    it "exercises after_remove_for_tutorial_views= somehow" do
      subject.after_remove_for_tutorial_views= 1
    end
  end
  context "after_remove_for_tutorial_views?" do
    it "exercises after_remove_for_tutorial_views? somehow" do
      subject.after_remove_for_tutorial_views? 
    end
  end
  context "autosave_associated_records_for_group" do
    it "exercises autosave_associated_records_for_group somehow" do
      subject.autosave_associated_records_for_group 
    end
  end
  context "autosave_associated_records_for_tutorial_likes" do
    it "exercises autosave_associated_records_for_tutorial_likes somehow" do
      subject.autosave_associated_records_for_tutorial_likes 
    end
  end
  context "autosave_associated_records_for_tutorial_views" do
    it "exercises autosave_associated_records_for_tutorial_views somehow" do
      subject.autosave_associated_records_for_tutorial_views 
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
  context "before_add_for_tutorial_views" do
    it "exercises before_add_for_tutorial_views somehow" do
      subject.before_add_for_tutorial_views 
    end
  end
  context "before_add_for_tutorial_views=" do
    it "exercises before_add_for_tutorial_views= somehow" do
      subject.before_add_for_tutorial_views= 1
    end
  end
  context "before_add_for_tutorial_views?" do
    it "exercises before_add_for_tutorial_views? somehow" do
      subject.before_add_for_tutorial_views? 
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
  context "before_remove_for_tutorial_views" do
    it "exercises before_remove_for_tutorial_views somehow" do
      subject.before_remove_for_tutorial_views 
    end
  end
  context "before_remove_for_tutorial_views=" do
    it "exercises before_remove_for_tutorial_views= somehow" do
      subject.before_remove_for_tutorial_views= 1
    end
  end
  context "before_remove_for_tutorial_views?" do
    it "exercises before_remove_for_tutorial_views? somehow" do
      subject.before_remove_for_tutorial_views? 
    end
  end
  context "next" do
    it "exercises next somehow" do
      subject.next 
    end
  end
  context "validate_associated_records_for_tutorial_likes" do
    it "exercises validate_associated_records_for_tutorial_likes somehow" do
      subject.validate_associated_records_for_tutorial_likes 
    end
  end
  context "validate_associated_records_for_tutorial_views" do
    it "exercises validate_associated_records_for_tutorial_views somehow" do
      subject.validate_associated_records_for_tutorial_views 
    end
  end

end
