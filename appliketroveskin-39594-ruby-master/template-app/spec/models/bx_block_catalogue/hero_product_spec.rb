require 'rails_helper'

RSpec.describe BxBlockCatalogue::HeroProduct, type: :model do
  it "Should assign tags before save" do
    product = BxBlockCatalogue::HeroProduct.create(tags_type: "default")
    expect(product.tags).to eql("")
  end
  it  { is_expected.to allow_values('default', 'customized').for(:tags_type) }

end
