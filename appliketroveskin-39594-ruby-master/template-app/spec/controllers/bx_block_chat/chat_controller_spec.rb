require 'rails_helper'
RSpec.describe BxBlockChat::ChatController, type: :controller do 

  describe 'GET create_chat' do
       before do
        @account = create(:account, freeze_account: false)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end    
     
         context "when create chat" do
         it 'Returns Customer is registered with us.' do
         get :create_chat, params: { use_route: "/chat/" , token: @token , user_id: @account.id}
         expect(response).to have_http_status(200)
         expect(JSON.parse(response.body)["message"]).to eql("Customer is registered with us.")
         end
      end

      context "when we pass incoorect user_id" do
         it 'returns Customer is not registered with us.' do
         get :create_chat, params: { token: @token, user_id: 23456}
         expect(response).to have_http_status(404)
         expect(JSON.parse(response.body)["message"]).to eql("Customer is not registered with us.")
        end
      end

      context "when we pass incorrect token" do
         it 'Returns Invalid token' do
         get :create_chat, params: { use_route: "/chat/" , token: nil , user_id: @account.id }
         expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
         end
      end
    end
 
   describe 'GET index' do
      before do
        @account = create(:account, freeze_account: false)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end    
     
      context "when we pass correct params" do
         it 'Returns success.' do
         get :index, params: { use_route: "/chat/" , token: @token , user_id: @account.id }
         expect(response).to have_http_status(200)
         end
      end
      context "when we pass incorrect params" do
         it 'Returns Invalid token' do
         get :index, params: { use_route: "/chat/" , token: nil , user_id: @account.id }
         expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
         end
      end
   end

   describe 'PUT disable_chats' do
       before do
        @account = create(:account, freeze_account: false)
        @therapist = create(:account, :with_therapist_role)
        @chat = create(:chat, therapist_type: "AccountBlock::Account", therapist_id: @therapist.id, account_id: @account.id)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end  
      context "when we pass correct params for chats disable" do
         it 'Returns Chats disabled successfully' do
         put :disable_chats, params: { use_route: "/chat/" , token: @token , data: {id: @chat.id } }
         expect(JSON.parse(response.body)["message"]).to eql("Chats disabled successfully")
         end
      end

      context "when we pass incorrect params for chats disable" do
         it 'Returns Invalid token' do
         put :disable_chats, params: { use_route: "/chat/" , token: nil , data: {id: @chat.id } }
         expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
         end
      end
   end

  
   describe 'PUT pin_or_unpin' do
      before do
        @account = create(:account, freeze_account: false)
        @therapist = create(:account, :with_therapist_role)
        @chat = create(:chat, therapist_type: "AccountBlock::Account", therapist_id: @therapist.id, account_id: @account.id )
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end  
     
      context "when we pass correct params for pin or unpin chat" do
         it 'Returns Chat pinned/unpinned successfully' do
         put :pin_or_unpin, params: { use_route: "/chat/" , token: @token  , data: {ids: [@chat.id]}},as: :json
         expect(JSON.parse(response.body)["message"]).to eql("Chat pinned/unpinned successfully")
         end
      end
   end


   describe 'GET show' do
      before do
        @account = create(:account, freeze_account: false)
        @therapist = create(:account, :with_therapist_role)
        @chat = create(:chat, therapist_type: "AccountBlock::Account", therapist_id: @therapist.id, account_id: @account.id, sid: nil)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end    
     
      context "when pass correct params" do
         it 'Returns show chat.' do
         get :show, params: { use_route: "/bx_block_chat/chat/" , token: @token , id: @chat.id  , sid: "test123"}
         expect(response).to have_http_status(200)
         end
      end

      context "when pass params end date " do
         it 'Returns This session has ended' do
         @chat.update(end_date: 1.day.before)
         get :show, params: { use_route: "/bx_block_chat/chat/" , token: @token , id: @chat.id },as: :json
         expect(response).to have_http_status(422)
         expect(JSON.parse(response.body)["errors"]).to eql(["This session has ended."])
         end
      end
   end


   describe 'POST send_message' do
       before do
        @account = create(:account, freeze_account: false)
        @therapist = create(:account, :with_therapist_role)
        @chat = create(:chat, therapist_type: "AccountBlock::Account", therapist_id: @therapist.id, account_id: @account.id)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end    
     
      context "when we pass correct params" do
         it 'Returns success.' do
         post :send_message , params: { use_route: "/chat/" , token: @token , id: @chat.id , data: { message: @chat.messages, message_objects_attributes: [ { object_id: "1", object_type: "Product", title: "TITLE", image_url: "345534", product_id: "23456765", variant_id: "2345654", price: 455.12 } ] } }
         expect(response).to have_http_status(200)
         end
      end

      context "when we pass incorrect params" do
         it 'Returns success.' do
         post :send_message , params: { use_route: "/chat/" , token: @token ,  data: {message_objects_attributes: [ { object_id: "1", object_type: "Product", title: "TITLE", image_url: "345534", product_id: "23456765", variant_id: "2345654", price: 455.12 } ] } }
         expect(JSON.parse(response.body)["errors"]["message"]).to eql("Record not found")
         end
      end
   end



   describe 'PUT mark_unread' do
       before do
        @account = create(:account, freeze_account: false)
        @therapist = create(:account, :with_therapist_role)
        @chat = create(:chat, therapist_type: "AccountBlock::Account", therapist_id: @therapist.id, account_id: @account.id)
        @message = create(:message, chat: @chat, account: @account)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end    
      context "when pass correct params" do
         it 'Returns Messages marked as unread' do
         put :mark_unread, params: { use_route: "/chat/" , token: @token , data: {ids: [@chat.id] } },as: :json
         expect(JSON.parse(response.body)["message"]).to eql("Messages marked as unread")
         end
      end
   end
end

