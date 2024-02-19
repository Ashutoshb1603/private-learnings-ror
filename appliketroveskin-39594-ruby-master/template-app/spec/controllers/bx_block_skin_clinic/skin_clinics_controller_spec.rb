require 'rails_helper'
RSpec.describe BxBlockSkinClinic::SkinClinicsController, type: :controller do

describe 'get index' do
  before do
    @account = create(:account , freeze_account: false)
     # @skin_clinic = create(:skin_clinic, clinic_link: @account)
     # @page_click = create(:page_click , accountable: @account)
     # @skin_clinic_availability = create(:skin_clinic_availability, skin_clinic: @skin_clinic)
     # @skin_treatment_location = cre ,ate(:skin_treatment_location)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
    get :index, params: { use_route: "/skin_clinics/" , token: @token , id: @account.id , location: "uk"}
    expect(response).to have_http_status(200)
    end
  end

  context "when we list skin clinics without location" do
    it 'Returns Please pass location to get skin clinics around you.' do
    get :index, params: { use_route: "/skin_clinics/" , token: @token , id: @account.id }
      expect(JSON.parse(response.body)["errors"]["message"]).to eql("Please pass location to get skin clinics around you.")
    end
  end

  context "when pass incorrect params" do
    it 'Returns Invalid token' do
    get :index, params: {use_route: "/skin_clinics/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end

  context "when we list skin clinics with Freezed account" do
    it 'Returns Please Unfreeze first' do
    token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    @account.update(jwt_token: @account.jwt_token, freeze_account: true)
    get :index, params: { use_route: "/skin_clinics/" , token: @token , id: @account.id , location: "uk"}
    expect(JSON.parse(response.body)).to eq({"errors"=> {"message"=>"Account is Freezed. Please Unfreeze first"}})
    end
  end
end

describe 'get show' do
  before do
    @account = create(:account , freeze_account: false)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end
  let(:skin_clinic) { create(:skin_clinic) }
  context "when pass correct params" do
    it 'Returns success' do
      get :show, params: { use_route: "/skin_clinics/" , token: @token , id: skin_clinic.id , location: "uk"}
      expect(response).to have_http_status(200)
    end
  end

  context "when we show skin clinics without location" do
    it 'Returns Please pass location to get skin clinics around you.' do
      get :show, params: { use_route: "/skin_clinics/", token: @token, id:skin_clinic.id  }
      sample = ["id", "name", "location", "country", "latitude", "longitude", "created_at", "updated_at", "clinic_link", "availabilities"]
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["data"]["attributes"].keys).to match_array(sample)
    end
  end

  context "when pass incorrect params" do
    it 'Returns Invalid token' do
    get :show, params: {use_route: "/skin_clinics/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end

end
