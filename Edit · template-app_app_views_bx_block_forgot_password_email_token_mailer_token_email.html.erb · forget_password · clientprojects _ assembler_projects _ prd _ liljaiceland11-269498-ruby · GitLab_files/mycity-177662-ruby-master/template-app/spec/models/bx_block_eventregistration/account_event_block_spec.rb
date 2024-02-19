require 'rails_helper'

RSpec.describe BxBlockEventregistration::AccountEventBlock, :type => :model do
  subject { described_class.new }
  

  it "is valid with valid attributes" do
    subject.account_id = 1
    subject.event_block_id = 1
    expect(subject.event_block_id).to eq 1
  end

  it "is not valid without an account" do 
    subject.event_block_id = 1
    expect(subject).to be_invalid
  end

  it "is not valid without an event" do 
    subject.account_id = 1
    expect(subject).to be_invalid
  end
end
