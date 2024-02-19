require 'rails_helper'

RSpec.describe BxBlockCatalogue::Advertisement, type: :model do
  let (:advertisement) { build(:advertisement, :attach_png_image) }
  it { should have_many(:page_clicks).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:dimension) }
  # it "Should have attached image" do
  #   expect(advertisement).to be_valid
  # end
  it { is_expected.to have_one(:image_attachment) }
  # it "Should have valid url" do
  #   advertisement = build(:advertisement, :valid_url)
  #   expect(advertisement).to be_valid
  # end
  # it "Image should have valid content type" do
  #   expect(advertisement).to be_valid
  # end
end
