require 'rails_helper'

RSpec.describe BxBlockCatalogue::CustomerFavouriteProduct, type: :model do
  it { is_expected.to belong_to(:account) }
end
