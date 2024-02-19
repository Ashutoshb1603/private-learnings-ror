require 'rails_helper'

describe BxBlockExplanationText::ExplanationText, :type => :model do
  # let (:subject) { build :bx_block_explanation_text/explanation_text }
  context "validation" do
    it { should validate_presence_of :section_name }
    it { should validate_presence_of :value }
  end
  context "associations" do
  end

end
