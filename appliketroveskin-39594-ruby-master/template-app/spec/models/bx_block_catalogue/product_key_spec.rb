require 'rails_helper'

RSpec.describe BxBlockCatalogue::ProductKey, type: :model do
  it  { is_expected.to allow_values('Ireland', 'Uk').for(:location) }
end
