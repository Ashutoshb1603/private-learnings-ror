require 'rails_helper'

RSpec.describe BxBlockHiddenPlaces::GooglePlaceIntegration, :type => :model do
  subject { described_class.new }
  

  it "should create record with callback invoke" do
    subject = described_class.new({city: 'madurai', latitude: '9.9261153', longitude: "78.1140983"})
    subject.save
    expect(subject).to receive(:process_api)
    subject.run_callbacks(:create)  
  end

  it 'should create and call google place api' do
    subject = described_class.new({city: 'madurai', latitude: '9.9261153', longitude: "78.1140983"})
    subject.save
    allow(subject).to receive(:process_api).and_return(nil)
    expect(BxBlockHiddenPlaces::GooglePlaceIntegration.count).to eq(1)
  end
end
