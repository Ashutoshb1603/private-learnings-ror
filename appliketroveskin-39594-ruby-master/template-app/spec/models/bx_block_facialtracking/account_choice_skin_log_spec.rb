require 'rails_helper'

describe BxBlockFacialtracking::AccountChoiceSkinLog, :type => :model do
  # let (:subject) { build :bx_block_facialtracking/account_choice_skin_log }
  # context "validation" do
  #   it { should validate_presence_of :account }
  #   it { should validate_presence_of :skin_quiz }
  #   it { should validate_presence_of :choice_ids }
  # end
  context "associations" do
    # it { should belong_to :account }
    # it { should belong_to :skin_quiz }
    it { should have_one :image_attachment }
    it { should have_one :image_blob }
  end
  context "autosave_associated_records_for_account" do
    it "exercises autosave_associated_records_for_account somehow" do
      subject.autosave_associated_records_for_account 
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
  context "choices" do
    it "exercises choices somehow" do
      subject.choices 
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
  # context "validate_choice_length" do
  #   it "exercises validate_choice_length somehow" do
  #     subject.validate_choice_length 
  #   end
  # end
  context "validate_choices" do
    it "exercises validate_choices somehow" do
      subject.validate_choices 
    end
  end

end
