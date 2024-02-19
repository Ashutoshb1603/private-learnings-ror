require 'rails_helper'

RSpec.describe BxBlockAddress::Address, :type => :model do
  let (:address) { FactoryBot.create(:address, :with_associations) }
  let!(:address_type) do 
    { "Home": 0, "Work": 1, "Other": 2 }
  end
  subject {BxBlockAddress::Address.new(address_type: "Other", street: "B/67", county: "abc", county: "India", postcode: 123443)}
  it { is_expected.to belong_to(:addressable) }
  it { is_expected.to validate_presence_of(:address_type) }
  it { is_expected.to validate_presence_of(:street) }
  it { is_expected.to validate_presence_of(:county) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:postcode) }
  # it "Adds address type for address if address_type is not present"do
  #   @address = BxBlockAddress::Address.new()
  #   expect(@user).to receive(:create_in_remote) 
  #   @user.run_callbacks(:create) 
  # end
  it "has valid address type" do
    address_type.each do |type, value|
      subject.address_type = value
      subject.save
      expect(subject.address_type).to eql(type.to_s)
    end
  end
end