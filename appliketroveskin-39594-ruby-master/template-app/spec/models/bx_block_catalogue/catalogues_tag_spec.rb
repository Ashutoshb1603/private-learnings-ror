require 'rails_helper'

RSpec.describe BxBlockCatalogue::CataloguesTag, type: :model do
  it { is_expected.to belong_to(:catalogue) }
  it { is_expected.to belong_to(:tag) }
end
