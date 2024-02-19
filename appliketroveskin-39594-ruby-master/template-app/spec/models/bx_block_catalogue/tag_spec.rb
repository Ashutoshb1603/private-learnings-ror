require 'rails_helper'

describe BxBlockCatalogue::Tag, :type => :model do
  # let (:subject) { build :bx_block_catalogue/tag }
  context "validation" do
    it { should validate_presence_of :title }
  end
  context "associations" do
    it { should have_and_belong_to_many :catalogue }
    it { should have_many :choice_tags }
    it { should have_many :choices }
  end
  context "after_add_for_bxblockcatalogue_tags_catalogue" do
    it "exercises after_add_for_bxblockcatalogue_tags_catalogue somehow" do
      subject.after_add_for_bxblockcatalogue_tags_catalogue 
    end
  end
  context "after_add_for_bxblockcatalogue_tags_catalogue=" do
    it "exercises after_add_for_bxblockcatalogue_tags_catalogue= somehow" do
      subject.after_add_for_bxblockcatalogue_tags_catalogue= 1
    end
  end
  context "after_add_for_bxblockcatalogue_tags_catalogue?" do
    it "exercises after_add_for_bxblockcatalogue_tags_catalogue? somehow" do
      subject.after_add_for_bxblockcatalogue_tags_catalogue? 
    end
  end
  context "after_add_for_catalogue" do
    it "exercises after_add_for_catalogue somehow" do
      subject.after_add_for_catalogue 
    end
  end
  context "after_add_for_catalogue=" do
    it "exercises after_add_for_catalogue= somehow" do
      subject.after_add_for_catalogue= 1
    end
  end
  context "after_add_for_catalogue?" do
    it "exercises after_add_for_catalogue? somehow" do
      subject.after_add_for_catalogue? 
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
  context "after_remove_for_bxblockcatalogue_tags_catalogue" do
    it "exercises after_remove_for_bxblockcatalogue_tags_catalogue somehow" do
      subject.after_remove_for_bxblockcatalogue_tags_catalogue 
    end
  end
  context "after_remove_for_bxblockcatalogue_tags_catalogue=" do
    it "exercises after_remove_for_bxblockcatalogue_tags_catalogue= somehow" do
      subject.after_remove_for_bxblockcatalogue_tags_catalogue= 1
    end
  end
  context "after_remove_for_bxblockcatalogue_tags_catalogue?" do
    it "exercises after_remove_for_bxblockcatalogue_tags_catalogue? somehow" do
      subject.after_remove_for_bxblockcatalogue_tags_catalogue? 
    end
  end
  context "after_remove_for_catalogue" do
    it "exercises after_remove_for_catalogue somehow" do
      subject.after_remove_for_catalogue 
    end
  end
  context "after_remove_for_catalogue=" do
    it "exercises after_remove_for_catalogue= somehow" do
      subject.after_remove_for_catalogue= 1
    end
  end
  context "after_remove_for_catalogue?" do
    it "exercises after_remove_for_catalogue? somehow" do
      subject.after_remove_for_catalogue? 
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
  context "autosave_associated_records_for_bxblockcatalogue_tags_catalogue" do
    it "exercises autosave_associated_records_for_bxblockcatalogue_tags_catalogue somehow" do
      subject.autosave_associated_records_for_bxblockcatalogue_tags_catalogue 
    end
  end
  context "autosave_associated_records_for_catalogue" do
    it "exercises autosave_associated_records_for_catalogue somehow" do
      subject.autosave_associated_records_for_catalogue 
    end
  end
  context "autosave_associated_records_for_choice_tags" do
    it "exercises autosave_associated_records_for_choice_tags somehow" do
      subject.autosave_associated_records_for_choice_tags 
    end
  end
  context "autosave_associated_records_for_choices" do
    it "exercises autosave_associated_records_for_choices somehow" do
      subject.autosave_associated_records_for_choices 
    end
  end
  context "before_add_for_bxblockcatalogue_tags_catalogue" do
    it "exercises before_add_for_bxblockcatalogue_tags_catalogue somehow" do
      subject.before_add_for_bxblockcatalogue_tags_catalogue 
    end
  end
  context "before_add_for_bxblockcatalogue_tags_catalogue=" do
    it "exercises before_add_for_bxblockcatalogue_tags_catalogue= somehow" do
      subject.before_add_for_bxblockcatalogue_tags_catalogue= 1
    end
  end
  context "before_add_for_bxblockcatalogue_tags_catalogue?" do
    it "exercises before_add_for_bxblockcatalogue_tags_catalogue? somehow" do
      subject.before_add_for_bxblockcatalogue_tags_catalogue? 
    end
  end
  context "before_add_for_catalogue" do
    it "exercises before_add_for_catalogue somehow" do
      subject.before_add_for_catalogue 
    end
  end
  context "before_add_for_catalogue=" do
    it "exercises before_add_for_catalogue= somehow" do
      subject.before_add_for_catalogue= 1
    end
  end
  context "before_add_for_catalogue?" do
    it "exercises before_add_for_catalogue? somehow" do
      subject.before_add_for_catalogue? 
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
  context "before_remove_for_bxblockcatalogue_tags_catalogue" do
    it "exercises before_remove_for_bxblockcatalogue_tags_catalogue somehow" do
      subject.before_remove_for_bxblockcatalogue_tags_catalogue 
    end
  end
  context "before_remove_for_bxblockcatalogue_tags_catalogue=" do
    it "exercises before_remove_for_bxblockcatalogue_tags_catalogue= somehow" do
      subject.before_remove_for_bxblockcatalogue_tags_catalogue= 1
    end
  end
  context "before_remove_for_bxblockcatalogue_tags_catalogue?" do
    it "exercises before_remove_for_bxblockcatalogue_tags_catalogue? somehow" do
      subject.before_remove_for_bxblockcatalogue_tags_catalogue? 
    end
  end
  context "before_remove_for_catalogue" do
    it "exercises before_remove_for_catalogue somehow" do
      subject.before_remove_for_catalogue 
    end
  end
  context "before_remove_for_catalogue=" do
    it "exercises before_remove_for_catalogue= somehow" do
      subject.before_remove_for_catalogue= 1
    end
  end
  context "before_remove_for_catalogue?" do
    it "exercises before_remove_for_catalogue? somehow" do
      subject.before_remove_for_catalogue? 
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
  context "name" do
    it "exercises name somehow" do
      subject.name 
    end
  end
  context "validate_associated_records_for_bxblockcatalogue_tags_catalogue" do
    it "exercises validate_associated_records_for_bxblockcatalogue_tags_catalogue somehow" do
      subject.validate_associated_records_for_bxblockcatalogue_tags_catalogue 
    end
  end
  context "validate_associated_records_for_catalogue" do
    it "exercises validate_associated_records_for_catalogue somehow" do
      subject.validate_associated_records_for_catalogue 
    end
  end
  context "validate_associated_records_for_choice_tags" do
    it "exercises validate_associated_records_for_choice_tags somehow" do
      subject.validate_associated_records_for_choice_tags 
    end
  end
  context "validate_associated_records_for_choices" do
    it "exercises validate_associated_records_for_choices somehow" do
      subject.validate_associated_records_for_choices 
    end
  end

end
