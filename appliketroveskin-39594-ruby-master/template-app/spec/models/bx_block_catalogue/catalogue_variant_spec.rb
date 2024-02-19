require 'rails_helper'
RSpec.describe BxBlockCatalogue::CatalogueVariant, type: :model do
  it { is_expected.to belong_to(:catalogue) }
  it { is_expected.to belong_to(:catalogue_variant_color).optional(:true) }
  it { is_expected.to belong_to(:catalogue_variant_size).optional(:true) }
  it { is_expected.to have_many(:images_attachments).dependent(:destroy) }
end
