require 'rails_helper'

RSpec.describe BxBlockRolesPermissions::Role, :type => :model do
  let (:role) { FactoryBot.create(:role, :with_associations) }

  # it { should have_many(:role_permissions) }
  it { is_expected.to have_many(:role_permissions) }
  it { should have_many(:permissions).through(:role_permissions) }
  it { should have_many(:accounts).dependent(:destroy) }
  # it { is_expected.to validate_presence_of(:name) }
  # it { should validate_uniqueness_of(:name) }
  it do
    should accept_nested_attributes_for(:permissions).allow_destroy(true)
  end
end