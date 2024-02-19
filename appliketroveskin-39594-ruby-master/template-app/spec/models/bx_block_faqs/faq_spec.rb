require 'rails_helper'

describe BxBlockFaqs::Faq, :type => :model do
  # let (:subject) { build :bx_block_faqs/faq }
  context "validation" do
    it { should validate_presence_of :question }
    it { should validate_presence_of :answer }
  end
  context "associations" do
  end

end
