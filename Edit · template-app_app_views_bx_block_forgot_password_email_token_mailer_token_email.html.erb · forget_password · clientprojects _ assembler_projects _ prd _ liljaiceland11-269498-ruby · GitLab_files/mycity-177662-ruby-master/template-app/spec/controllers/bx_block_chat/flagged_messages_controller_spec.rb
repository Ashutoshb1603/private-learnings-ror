require 'rails_helper'

RSpec.describe BxBlockChat::FlaggedMessagesController, type: :controller do
	let(:user) { AccountBlock::Account.create!(full_name: "aaa", email: "aaa@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
  let(:token) {BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')}
	let(:flagged_message) {BxBlockChat::FlaggedMessage.create!(conversation_sid: "AScugascashcvhavsc", message_sid: "IMjaghscuyvasuc")}

	describe "Creates a flagged message" do
		it "should mark a message flagged" do
			@request.headers[:token] =  token
			post :create, { params: { conversation_sid: "AScugascashcvhavsc", message_sid: "IMjaghscuyvasuc", account_id: user.id } } 
			expect(response).to have_http_status(:created)
			expect(BxBlockChat::FlaggedMessage.count).to eq 1
		end
	end

	describe "Index" do
		it "should return list of flagged messages" do
			@request.headers[:token] =  token
			flagged_message
			get :index, { params: { conversation_sid: "AScugascashcvhavsc"}}
			expect(response).to have_http_status(:ok)
			expect(BxBlockChat::FlaggedMessage.count).to eq 1
		end
	end

	describe "Unflag" do
		it "should unflag a message" do
			@request.headers[:token] =  token
			flagged_message
			flagged_message.flagged_message_accounts.create(account_id: user.id)
			delete :unflag_message, { params: { conversation_sid: "AScugascashcvhavsc", message_sid: "IMjaghscuyvasuc", account_id: user.id }}
			expect(response).to have_http_status(:ok)
		end
	end
end