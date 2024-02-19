require 'rails_helper'

RSpec.describe BxBlockChat::ChatsController, type: :controller do
  let(:user) { AccountBlock::Account.create!(full_name: "aaa", email: "aaa@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
  let(:chat) { FactoryBot.create(:chat) }
	let(:token) {BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')}

  describe 'Index' do
    context 'It returns all the chats of current user' do
      it 'should return current user chats' do
        @request.headers[:token] =  token
        chat.update(chat_type: 1)
        chat.accounts_chats.create(account_id: user.id)
        expect(response).to have_http_status(:ok)
			  expect(BxBlockChat::Chat.multiple_user_chats&.count).to eq 1
      end
    end
  end

  describe 'Show' do
    context 'Show a chat object' do
      it 'should return a chat object' do
        @request.headers[:token] =  token
        get :show, params: {id: "", conversation_sid: chat.conversation_sid}
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe 'Access token' do
    context 'get access token' do
      it 'should return an access token' do
        @request.headers[:token] =  token
        get :get_access_token
        expect(response).to have_http_status(:ok)
      end
    end
  end
end