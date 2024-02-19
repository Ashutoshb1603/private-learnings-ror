require 'rails_helper'
RSpec.describe BxBlockCatalogue::ReviewsController, type: :controller do
describe 'POST create' do
let(:category) { create(:category) }
let(:sub_category) { create(:sub_category) }
let(:catalogue) { create(:catalogue, category: category, sub_category: sub_category) }
before do
  @account = create(:account , freeze_account: false)
  @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
end
context "when we create catalogues variants size with correct params" do
  it 'Returns created' do
    post :create, params: {token: @token, catalogue_id: catalogue.id}
    sample = ["id", "catalogue_id", "rating", "comment", "created_at", "updated_at"]
    expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
    expect(response). to have_http_status(201)
  end
end
context "when we create catalogues variants size with incorrect params" do
  it 'Returns Invalid token' do
    post :create, params: {token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
  end
end
  end
describe 'GET index' do
before do
  @account = create(:account , freeze_account: false)
  @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
end
context "when we get list catalogues variants size with correct params" do
  it 'Returns created' do
    get :index, params: {token: @token}
    expect(response). to have_http_status(200)
  end
end
context "when we get list catalogues variants size with incorrect params" do
  it 'Returns Invalid token' do
    get :index, params: {token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
  end
end
  end
end
