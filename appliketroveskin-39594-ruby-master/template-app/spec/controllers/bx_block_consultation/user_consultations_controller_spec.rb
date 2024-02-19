require 'rails_helper'
RSpec.describe BxBlockConsultation::UserConsultationsController, type: :controller do

  describe 'POST create' do
       before do
        @account = create(:account, freeze_account: false)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end

      context "when pass correct params" do
         it 'Returns create user consultation.' do
         post :create, params: { token: @token, user_consultation:{name: @account.name, phone_number: @account.full_phone_number, email: @account.email, age: @account.age, address: "sector 11, Gandhinagar", booked_datetime: "20-05-2021 15:00:00", therapist_id: "45454"}}
         expect(response).to have_http_status(201)
      end
       end

      context "when pass incorrect params" do
         it 'Returns success.' do
         post :create, params: { token: @token, user_consultation:{name: "", phone_number: @account.full_phone_number, email: @account.email, age: @account.age, address: "sector 11, Gandhinagar", booked_datetime: "20-05-2021 15:00:00", therapist_id: "45454"}}
         expect(response).to have_http_status(422)
         expect(JSON.parse(response.body)["errors"]["message"]).to eql(["Name can't be blank"])
      end
       end
   end

   describe 'GET user_consultation' do
     before do
      @account = create(:account, freeze_account: false )
      # @user_consultation = create(:user_consultation )
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
       it 'Returns show user consultation' do
       get :user_consultation, params: { token: @token}
       expect(response).to have_http_status(200)
    end
     end
 end
end
