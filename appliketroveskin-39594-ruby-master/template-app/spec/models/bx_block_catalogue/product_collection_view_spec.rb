require 'rails_helper'

RSpec.describe BxBlockCatalogue::ProductCollectionView, type: :model do
  it { is_expected.to belong_to(:accountable) }
end
