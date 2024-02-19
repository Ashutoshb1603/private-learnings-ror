require 'rails_helper'

RSpec.describe BxBlockCatalogue::Catalogue, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:sub_category) }
  it { is_expected.to belong_to(:brand).optional(:true) }
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:catalogue_variants).dependent(:destroy) }
  it { should have_and_belong_to_many(:tags) }
  it { is_expected.to have_many(:images_attachments).dependent(:destroy) }
end
