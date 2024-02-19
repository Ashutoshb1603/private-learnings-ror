require 'rails_helper'

RSpec.describe AccountBlock::ActiveHour, :type => :model do
  it "is valid with valid attributes" do
    active_hour = build :active_hour
    expect(active_hour).to be_valid
  end
end
