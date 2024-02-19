require 'rails_helper'

describe BxBlockCommunityforum::Group, :type => :model do
  # let (:subject) { build :bx_block_communityforum/group }
  context "validation" do
  end
  context "associations" do
    it { should have_many :question_tags }
    it { should have_many :questions }
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
  context "autosave_associated_records_for_question_tags" do
    it "exercises autosave_associated_records_for_question_tags somehow" do
      subject.autosave_associated_records_for_question_tags 
    end
  end
  context "autosave_associated_records_for_questions" do
    it "exercises autosave_associated_records_for_questions somehow" do
      subject.autosave_associated_records_for_questions 
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
  context "validate_associated_records_for_question_tags" do
    it "exercises validate_associated_records_for_question_tags somehow" do
      subject.validate_associated_records_for_question_tags 
    end
  end
  context "validate_associated_records_for_questions" do
    it "exercises validate_associated_records_for_questions somehow" do
      subject.validate_associated_records_for_questions 
    end
  end

end
