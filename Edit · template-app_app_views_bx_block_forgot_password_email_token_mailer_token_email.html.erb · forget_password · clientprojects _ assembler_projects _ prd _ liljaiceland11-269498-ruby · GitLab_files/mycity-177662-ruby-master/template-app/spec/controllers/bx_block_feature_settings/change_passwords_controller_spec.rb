require 'rails_helper'
RSpec.describe AccountBlock::Account, type: :request do
  before :context do
    @account = FactoryBot.create(:Account, email: Faker::Internet.safe_email,user_name:Faker::Name.name, full_name: Faker::Name.name, password: "Abc@12345", activated: true)
    @token = BuilderJsonWebToken::JsonWebToken.encode(@account.id)
    @request_params = { token: @token, :data => {new_password: "Password@123", confirm_password: "Password@123"},format: :json }
  end
    # describe "get#index" do
  		# context 'index for account' do
  		#   it 'will return data' do
    #       account = @account
  		#     get "//bx_block_account/account", params: @request_params
  		#     expect(response).to have_http_status 200
  		#   end
  		# end
    # end
    # describe 'post#create' do
    #   context 'create for account' do
    #     it 'returns correct result' do
    #       account = AccountBlock::Account.pluck(:id).first(3)
    #       account = FactoryBot.create(:account, moderator_ids: account, category_ids: @category.id, sub_category_ids: @sub_category.id, preference_ids: @preference.id, user_ids: @user, description: "test")
    #       expect(AccountBlock::Account.find(@account.id).description == "test")
    #     end
    #   end
    # end
    # describe "get#show" do
    #   context 'show for account' do
    #     it 'will return data' do
    #       account = @account
    #       expect(AccountBlock::Account.find(account.id))
    #     end
    #   end
    # end
    # describe 'delete#destroy' do
    #   context 'delete for account' do
    #     it "DELETE will cause an exception" do
    #       account = @account
    #       delete "/bx_block_accountforum/account/#{account.id}"
    #       expect(response).to have_http_status(400)
    #     end
    #   end
    # end
    describe 'puts#update' do
  		context 'update for account' do
  		  it 'returns correct result' do
          put "/bx_block_feature_settings/change_passwords", params: @request_params
          expect(response).to have_http_status 200
  		  end
		  end
    end
end