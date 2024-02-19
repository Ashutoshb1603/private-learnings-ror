require 'rails_helper'

describe BxBlockContactUs::ContactsController, :type => :controller do 

  describe "POST /create" do
    let(:contact_params) do {
      data:
        {
          first_name: "ayu",
          last_name: "gupta",
          email: "ayu@gmail.com",
          company_name: "test company",
          phone_number:"919875324321",
          description: "test"
        }
      }
    end

    it 'returns successful response' do
      post :create, params: contact_params
      response_json = JSON.parse(response.body)
      expect(response_json['data']['id']).not_to be_nil
      expect(response).to have_http_status 201
    end
    it 'returns error response' do
      post :create, params: {"data": { "first_name": "test" } } 
      response_json = JSON.parse(response.body)
      expect(response_json['errors'][0]["contact"][0]).to eq "Email can't be blank"
      expect(response).to have_http_status 422
    end
  end

  describe 'GET /index' do
    context "for contact list" do
      it "with contact list" do
        contact = FactoryBot.create(:contact)
        get :index
        response_json = JSON.parse(response.body)
        expect(response).to have_http_status 200
      end
      it 'without contact list' do
        get :index
        response_json = JSON.parse(response.body)
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /show' do
    it 'with valid attribute' do
      contact = FactoryBot.create(:contact)
      get :show, params: { id: contact.id }
      response_json = JSON.parse(response.body)
      expect(response_json['data']['attributes']['first_name']).to eq contact.first_name
      expect(response).to have_http_status 200
    end
    it 'with invalid attribute' do
      contact = FactoryBot.create(:contact)
      get :show, params: { id: 0}
      response_json = JSON.parse(response.body)
      expect(response_json['errors'][0]['contact']).to eq "Contact Not Found"
      expect(response).to have_http_status 404
    end
  end

  describe 'PUT /update' do
    it 'with valid attribute' do
      contact = FactoryBot.create(:contact)
      put :update, params: { id: contact.id, "data": { first_name: "testt"} }
      response_json = JSON.parse(response.body)
      expect(response_json['data']['attributes']['first_name']).to eq 'testt'
      expect(response).to have_http_status 200
    end
    it 'with invalid attribute' do
      contact = FactoryBot.create(:contact)
      put :update, params: { id: 0}
      response_json = JSON.parse(response.body)
      expect(response_json['errors'][0]['contact']).to eq "Contact Not Found"
      expect(response).to have_http_status 404
    end
  end

  describe 'DELETE /delete' do
    it 'when record delete successfully' do
      contact = FactoryBot.create(:contact)
      delete :destroy, params: { id: contact.id}
      expect(response).to have_http_status 200
    end
  end
end
