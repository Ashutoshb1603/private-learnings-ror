require 'rails_helper'

describe BxBlockFacialtracking::SkinQuiz, :type => :model do
  # let (:subject) { build :bx_block_facialtracking/skin_quiz }
  context "validation" do
    it { should validate_presence_of :question }
    it { should validate_presence_of :seq_no }
    it { should validate_presence_of :question_type }
    # it "uniqueness_validator test for [:seq_no]"
  end
  context "associations" do
    it { should have_many :choices }
    it { should have_many :account_choice_skin_quizzes }
    it { should have_many :account_choice_skin_logs }
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
  context "after_add_for_account_choice_skin_quizzes" do
    it "exercises after_add_for_account_choice_skin_quizzes somehow" do
      subject.after_add_for_account_choice_skin_quizzes 
    end
  end
  context "after_add_for_account_choice_skin_quizzes=" do
    it "exercises after_add_for_account_choice_skin_quizzes= somehow" do
      subject.after_add_for_account_choice_skin_quizzes= 1
    end
  end
  context "after_add_for_account_choice_skin_quizzes?" do
    it "exercises after_add_for_account_choice_skin_quizzes? somehow" do
      subject.after_add_for_account_choice_skin_quizzes? 
    end
  end
  context "after_add_for_choices" do
    it "exercises after_add_for_choices somehow" do
      subject.after_add_for_choices 
    end
  end
  context "after_add_for_choices=" do
    it "exercises after_add_for_choices= somehow" do
      subject.after_add_for_choices= 1
    end
  end
  context "after_add_for_choices?" do
    it "exercises after_add_for_choices? somehow" do
      subject.after_add_for_choices? 
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
  context "after_remove_for_account_choice_skin_quizzes" do
    it "exercises after_remove_for_account_choice_skin_quizzes somehow" do
      subject.after_remove_for_account_choice_skin_quizzes 
    end
  end
  context "after_remove_for_account_choice_skin_quizzes=" do
    it "exercises after_remove_for_account_choice_skin_quizzes= somehow" do
      subject.after_remove_for_account_choice_skin_quizzes= 1
    end
  end
  context "after_remove_for_account_choice_skin_quizzes?" do
    it "exercises after_remove_for_account_choice_skin_quizzes? somehow" do
      subject.after_remove_for_account_choice_skin_quizzes? 
    end
  end
  context "after_remove_for_choices" do
    it "exercises after_remove_for_choices somehow" do
      subject.after_remove_for_choices 
    end
  end
  context "after_remove_for_choices=" do
    it "exercises after_remove_for_choices= somehow" do
      subject.after_remove_for_choices= 1
    end
  end
  context "after_remove_for_choices?" do
    it "exercises after_remove_for_choices? somehow" do
      subject.after_remove_for_choices? 
    end
  end
  context "autosave_associated_records_for_account_choice_skin_logs" do
    it "exercises autosave_associated_records_for_account_choice_skin_logs somehow" do
      subject.autosave_associated_records_for_account_choice_skin_logs 
    end
  end
  context "autosave_associated_records_for_account_choice_skin_quizzes" do
    it "exercises autosave_associated_records_for_account_choice_skin_quizzes somehow" do
      subject.autosave_associated_records_for_account_choice_skin_quizzes 
    end
  end
  context "autosave_associated_records_for_choices" do
    it "exercises autosave_associated_records_for_choices somehow" do
      subject.autosave_associated_records_for_choices 
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
  context "before_add_for_account_choice_skin_quizzes" do
    it "exercises before_add_for_account_choice_skin_quizzes somehow" do
      subject.before_add_for_account_choice_skin_quizzes 
    end
  end
  context "before_add_for_account_choice_skin_quizzes=" do
    it "exercises before_add_for_account_choice_skin_quizzes= somehow" do
      subject.before_add_for_account_choice_skin_quizzes= 1
    end
  end
  context "before_add_for_account_choice_skin_quizzes?" do
    it "exercises before_add_for_account_choice_skin_quizzes? somehow" do
      subject.before_add_for_account_choice_skin_quizzes? 
    end
  end
  context "before_add_for_choices" do
    it "exercises before_add_for_choices somehow" do
      subject.before_add_for_choices 
    end
  end
  context "before_add_for_choices=" do
    it "exercises before_add_for_choices= somehow" do
      subject.before_add_for_choices= 1
    end
  end
  context "before_add_for_choices?" do
    it "exercises before_add_for_choices? somehow" do
      subject.before_add_for_choices? 
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
  context "before_remove_for_account_choice_skin_quizzes" do
    it "exercises before_remove_for_account_choice_skin_quizzes somehow" do
      subject.before_remove_for_account_choice_skin_quizzes 
    end
  end
  context "before_remove_for_account_choice_skin_quizzes=" do
    it "exercises before_remove_for_account_choice_skin_quizzes= somehow" do
      subject.before_remove_for_account_choice_skin_quizzes= 1
    end
  end
  context "before_remove_for_account_choice_skin_quizzes?" do
    it "exercises before_remove_for_account_choice_skin_quizzes? somehow" do
      subject.before_remove_for_account_choice_skin_quizzes? 
    end
  end
  context "before_remove_for_choices" do
    it "exercises before_remove_for_choices somehow" do
      subject.before_remove_for_choices 
    end
  end
  context "before_remove_for_choices=" do
    it "exercises before_remove_for_choices= somehow" do
      subject.before_remove_for_choices= 1
    end
  end
  context "before_remove_for_choices?" do
    it "exercises before_remove_for_choices? somehow" do
      subject.before_remove_for_choices? 
    end
  end
  context "update_choices" do
    it "exercises update_choices somehow" do
      subject.update_choices 
    end
  end
  context "validate_associated_records_for_account_choice_skin_logs" do
    it "exercises validate_associated_records_for_account_choice_skin_logs somehow" do
      subject.validate_associated_records_for_account_choice_skin_logs 
    end
  end
  context "validate_associated_records_for_account_choice_skin_quizzes" do
    it "exercises validate_associated_records_for_account_choice_skin_quizzes somehow" do
      subject.validate_associated_records_for_account_choice_skin_quizzes 
    end
  end
  context "validate_associated_records_for_choices" do
    it "exercises validate_associated_records_for_choices somehow" do
      subject.validate_associated_records_for_choices 
    end
  end
  context "validate_skin_quiz" do
    it "exercises validate_skin_quiz somehow" do
      subject.validate_skin_quiz 
    end
  end

end
