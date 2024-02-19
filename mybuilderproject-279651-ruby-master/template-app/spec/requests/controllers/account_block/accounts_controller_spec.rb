require 'rails_helper'

describe AccountBlock::AccountsController, :type => :controller do 

  describe '/account_block/accounts/get_country_list' do
    it 'should get country list' do
      get :get_country_list, format: :json
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe '/account_block/accounts' do
    context "with invalid attribute" do
      let(:invalid_params) do
        { data:{
          attributes: {
            operator_name:"abc",
            contact_name:"xyz",
            operator_address:"address",
            email: "test.com",
            full_phone_number:"91830538609",
            terms_and_conditions:"false"
          }}
        }
      end
      it "should not sign up" do
        post :create,  params: invalid_params 
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end
  describe "POST create" do
    let(:account_params) { { user_type: "user", full_phone_number: "1234567890", email: "test@example.com" } }
    let(:headers) { { "platform" => "ios" } }
    let(:request) { double(headers: headers, base_url: "http://example.com") }


    context "when account creation fails" do
      let(:account) { double(AccountBlock::Account, save: false, errors: { email: ["can't be blank"] }) }
      before do
        allow(AccountBlock::Account).to receive(:new).and_return(account)
        allow(account).to receive(:platform=).with("ios")
        allow(account).to receive(:user_type=).with("user")
        allow(account).to receive(:save).and_return(false)
      end

      it "returns unprocessable entity response with errors" do
        post :create, params: { data: { attributes: account_params } }

        expect(response.status).to eq(422)
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when the account already exists' do
      let!(:existing_account) { FactoryBot.create(:account, email: 'john.doe@example.com', full_phone_number: "7828808576", activated: true) }

      it 'returns an error message if the phone already registered' do
        post :create, params:  { 
             data: { 
                attributes: {
                    # user_type:"john.doe@example.com",
                    first_name:"abc",
                    last_name:"xyz",
                    email: "john.doe@example.com",
                    full_phone_number:"7828808576"
            } } }
        expect(response).to have_http_status(:ok)
        # expect(response.content_type).to eq('application/json')
        json = JSON.parse(response.body)
        # debugger
        expect(json["message"]).to eq(" Your account is already created, Please login.")
      end
    end

    context 'when the email id already exists' do
      let!(:existing_account) { FactoryBot.create(:account, email: 'john.doe@example.com', full_phone_number: '+15551234', activated: true) }

      it 'returns an error message if the email already registered' do
        post :create, params:  { 
             data: { 
                attributes: {
                    # user_type:"john.doe@example.com",
                    first_name:"abc",
                    last_name:"xyz",
                    email: "john.doe@example.com",
                    full_phone_number:"+15551234"
            } } }
        expect(response).to have_http_status(:ok)
        # expect(response.content_type).to eq('application/json')
        json = JSON.parse(response.body)
        expect(json["message"]).to eq(" Email id already exists, Please try to sign up using different email id.")
      end
    end


    context 'when the phone number already exists' do
      let!(:existing_account) { FactoryBot.create(:account, email: 'john.doe@example.com', full_phone_number: "7828808576", activated: true) }

      it 'returns an error message if the phone already registered' do
        post :create, params:  { 
             data: { 
                attributes: {
                    # user_type:"john.doe@example.com",
                    first_name:"abc",
                    last_name:"xyz",
                    email: "john.doeff@example.com",
                    full_phone_number:"7828808576"
            } } }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["message"]).to eq(" Phone number already exists, Please try to sign up using different phone number.")
      end
    end

    describe "#format_activerecord_errors" do
    context "when given a hash of errors" do
      let(:errors) { {name: ["can't be blank"], email: ["is invalid"]} }

      it "returns an array of attribute-error pairs" do
        expect(subject.send(:format_activerecord_errors, errors)).to eq([
          {name: ["can't be blank"]},
          {email: ["is invalid"]}
        ])
      end
    end
  end

  describe '#encode' do
    let(:id) { 123 }

    it 'returns an encoded JWT token' do
      expect(BuilderJsonWebToken).to receive(:encode).with(id).and_return('token')

      token = controller.send(:encode, id)

      expect(token).to eq('token')
    end
  end

  end
end