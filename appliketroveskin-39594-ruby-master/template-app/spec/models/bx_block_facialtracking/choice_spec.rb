require 'rails_helper'

describe BxBlockFacialtracking::Choice, :type => :model do
  # let (:subject) { build :bx_block_facialtracking/choice }
  # context "validation" do
  #   it { should validate_presence_of :skin_quiz }
  # end
  context "associations" do
    it { should belong_to :skin_quiz }
    it { should have_many :account_choice_skin_quizzes }
    it { should have_many :choice_tags }
    it { should have_many :tags }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
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
  context "after_add_for_choice_tags" do
    it "exercises after_add_for_choice_tags somehow" do
      subject.after_add_for_choice_tags 
    end
  end
  context "after_add_for_choice_tags=" do
    it "exercises after_add_for_choice_tags= somehow" do
      subject.after_add_for_choice_tags= 1
    end
  end
  context "after_add_for_choice_tags?" do
    it "exercises after_add_for_choice_tags? somehow" do
      subject.after_add_for_choice_tags? 
    end
  end
  context "after_add_for_tags" do
    it "exercises after_add_for_tags somehow" do
      subject.after_add_for_tags 
    end
  end
  context "after_add_for_tags=" do
    it "exercises after_add_for_tags= somehow" do
      subject.after_add_for_tags= 1
    end
  end
  context "after_add_for_tags?" do
    it "exercises after_add_for_tags? somehow" do
      subject.after_add_for_tags? 
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
  context "after_remove_for_choice_tags" do
    it "exercises after_remove_for_choice_tags somehow" do
      subject.after_remove_for_choice_tags 
    end
  end
  context "after_remove_for_choice_tags=" do
    it "exercises after_remove_for_choice_tags= somehow" do
      subject.after_remove_for_choice_tags= 1
    end
  end
  context "after_remove_for_choice_tags?" do
    it "exercises after_remove_for_choice_tags? somehow" do
      subject.after_remove_for_choice_tags? 
    end
  end
  context "after_remove_for_tags" do
    it "exercises after_remove_for_tags somehow" do
      subject.after_remove_for_tags 
    end
  end
  context "after_remove_for_tags=" do
    it "exercises after_remove_for_tags= somehow" do
      subject.after_remove_for_tags= 1
    end
  end
  context "after_remove_for_tags?" do
    it "exercises after_remove_for_tags? somehow" do
      subject.after_remove_for_tags? 
    end
  end
  context "autosave_associated_records_for_account_choice_skin_quizzes" do
    it "exercises autosave_associated_records_for_account_choice_skin_quizzes somehow" do
      subject.autosave_associated_records_for_account_choice_skin_quizzes 
    end
  end
  context "autosave_associated_records_for_choice_tags" do
    it "exercises autosave_associated_records_for_choice_tags somehow" do
      subject.autosave_associated_records_for_choice_tags 
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
  context "autosave_associated_records_for_skin_quiz" do
    it "exercises autosave_associated_records_for_skin_quiz somehow" do
      subject.autosave_associated_records_for_skin_quiz 
    end
  end
  context "autosave_associated_records_for_tags" do
    it "exercises autosave_associated_records_for_tags somehow" do
      subject.autosave_associated_records_for_tags 
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
  context "before_add_for_choice_tags" do
    it "exercises before_add_for_choice_tags somehow" do
      subject.before_add_for_choice_tags 
    end
  end
  context "before_add_for_choice_tags=" do
    it "exercises before_add_for_choice_tags= somehow" do
      subject.before_add_for_choice_tags= 1
    end
  end
  context "before_add_for_choice_tags?" do
    it "exercises before_add_for_choice_tags? somehow" do
      subject.before_add_for_choice_tags? 
    end
  end
  context "before_add_for_tags" do
    it "exercises before_add_for_tags somehow" do
      subject.before_add_for_tags 
    end
  end
  context "before_add_for_tags=" do
    it "exercises before_add_for_tags= somehow" do
      subject.before_add_for_tags= 1
    end
  end
  context "before_add_for_tags?" do
    it "exercises before_add_for_tags? somehow" do
      subject.before_add_for_tags? 
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
  context "before_remove_for_choice_tags" do
    it "exercises before_remove_for_choice_tags somehow" do
      subject.before_remove_for_choice_tags 
    end
  end
  context "before_remove_for_choice_tags=" do
    it "exercises before_remove_for_choice_tags= somehow" do
      subject.before_remove_for_choice_tags= 1
    end
  end
  context "before_remove_for_choice_tags?" do
    it "exercises before_remove_for_choice_tags? somehow" do
      subject.before_remove_for_choice_tags? 
    end
  end
  context "before_remove_for_tags" do
    it "exercises before_remove_for_tags somehow" do
      subject.before_remove_for_tags 
    end
  end
  context "before_remove_for_tags=" do
    it "exercises before_remove_for_tags= somehow" do
      subject.before_remove_for_tags= 1
    end
  end
  context "before_remove_for_tags?" do
    it "exercises before_remove_for_tags? somehow" do
      subject.before_remove_for_tags? 
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
  context "validate_associated_records_for_account_choice_skin_quizzes" do
    it "exercises validate_associated_records_for_account_choice_skin_quizzes somehow" do
      subject.validate_associated_records_for_account_choice_skin_quizzes 
    end
  end
  context "validate_associated_records_for_choice_tags" do
    it "exercises validate_associated_records_for_choice_tags somehow" do
      subject.validate_associated_records_for_choice_tags 
    end
  end
  context "validate_associated_records_for_tags" do
    it "exercises validate_associated_records_for_tags somehow" do
      subject.validate_associated_records_for_tags 
    end
  end
  context "validate_image_content_type" do
    it "exercises validate_image_content_type somehow" do
      subject.validate_image_content_type 
    end
  end

end
