require 'rails_helper'

RSpec.describe BxBlockCatalogue::ProductVideo, type: :model do
  let(:product_video) { FactoryBot.create(:product_video) }
  subject { product_video }
  it { is_expected.to validate_uniqueness_of(:product_id) }
  it "Converts the video url" do
    product_video.video_url = "https://www.youtube.com/watch?v=xpov5S6eprg"
    product_video.save
    expect(product_video.video_url).to match("https://www.youtube.com/embed/xpov5S6eprg")
  end
  #  it "Gives the list of products" do
  #   expect(BxBlockCatalogue::ProductVideo.products).to eql([])
  # end
end
