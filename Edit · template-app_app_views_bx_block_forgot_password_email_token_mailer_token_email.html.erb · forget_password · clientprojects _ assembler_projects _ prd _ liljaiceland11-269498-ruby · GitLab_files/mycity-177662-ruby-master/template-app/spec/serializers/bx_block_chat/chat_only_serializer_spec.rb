require 'rails_helper'

RSpec.describe BxBlockChat::ChatOnlySerializer, type: :serializer do
  let(:chat) { FactoryBot.create(:chat) }
  subject { BxBlockChat::ChatOnlySerializer.new(chat).serializable_hash }

  it 'it includes attributes' do
    expect(subject[:data][:attributes]).present?
  end

  it 'has a name that matches' do
    expect(subject[:data][:attributes][:name]).to eql("social_club_chat")
  end  

	it 'has an id' do
    expect(subject[:data][:attributes][:id].class).to eql(Integer)
  end  
end