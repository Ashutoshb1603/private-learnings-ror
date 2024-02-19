require 'rails_helper'

RSpec.describe BxBlockChat::FlaggedMessageSerializer, type: :serializer do
  let(:flagged_message) {BxBlockChat::FlaggedMessage.create!(conversation_sid: "AScugascashcvhavsc", message_sid: "IMjaghscuyvasuc")}
  let(:user) { AccountBlock::Account.create!(full_name: "aaa", email: "aaa@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
  subject { BxBlockChat::FlaggedMessageSerializer.new(flagged_message).serializable_hash }

  it 'it includes attributes' do
    expect(subject[:data][:attributes]).present?
  end

	it 'has an id' do
    expect(subject[:data][:attributes][:id].class).to eql(Integer)
  end

	it 'has account objects' do
		flagged_message.flagged_message_accounts.create(account_id: user.id)
    expect(subject[:data][:attributes][:accounts].class).to eql(Array)
  end
end