require 'rails_helper'
RSpec.describe BxBlockLogin::LoginsController, type: :controller do
  let(:user) { create(:email_account, :with_user_role , activated: true) }
  let(:therapist) { create(:email_account, :with_therapist_role) }
  let(:admin) { create(:admin_user) }
  describe 'POST login' do
    context "when given correct credential" do
       it 'Returns success' do
        account = user
        post :create, params: { data: { type: "email_account", attributes: { email: account.email, password: "test123" }, device: "android" } }
        expect(response).to have_http_status(200)
      end
    end
    context "when given incorrect credentials" do
      it 'Returns Account not found or activated' do
        post :create, params: { data: { type: "email_account", attributes: { email: "mandeeps@yopmail.com", password: "Password123" }, device: "android" }}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Account not found or activated")
      end
      it 'Returns Password is incorrect' do
        create(:email_account, :with_user_role, email: "abc@example.com")
        post :create, params: { data: { type: "email_account", attributes: { email: "abc@example.com", password: "123" }, device: "android" }}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Password is incorrect")
      end
      it 'Returns Invalid Account Type' do
        post :create, params: { data: { type: "other_account", attributes: {  email: "mandeeps.com", password: "123" }, device: "android" }}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid Account Type")
      end
    end
  end

  describe 'POST login' do
    before do
      @admin = create(:admin)
    end
      context "when given login admin account" do
       it 'Returns success' do
        post :create, params: { data: { type: "admin_account", attributes: { email: @admin.email, password: @admin.password }, device: "android" } }
        expect(response).to have_http_status(200)

      end
    end

    context "when given login admin account incorrect credentials" do
       it 'Returns Account not found or activated' do
        post :create, params: { data: { type: "admin_account", attributes: { email: "admin1@example.com", password: "admin123" }, device: "android" } }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Account not found or activated")
      end
    end

    context "when given login admin account incorrect password" do
       it 'Returns Password is incorrect' do
        post :create, params: { data: { type: "admin_account", attributes: { email: "admin1@example.com", password: "admin1234" }, device: "android" } }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Account not found or activated")
        end
    end


     context "when given login admin account incorrect email" do
       it 'Returns email is incorrect' do
        post :create, params: { data: { type: "admin_account", attributes: { email: "admin1@example.com", password: "admin1234" }, device: "android" } }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Account not found or activated")
      end
    end

    context "when given login admin account invalied account type" do
       it 'Returns Invalid Account type' do
        post :create, params: { data: { type: "other_account", attributes: { email: "admin1@example.com", password: "admin1234" }, device: "android" } }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid Account Type")
      end
    end



     end
end

