require 'rails_helper'
RSpec.describe BxBlockNotifications::NotificationsController, type: :controller do

describe 'POST create' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end


context "when we create notification with correct params" do
  it 'Returns Notification created' do
    post :create, params: { use_route: "/notifications/" , token: @token, notification: { headings: @notification.headings, contents: @notification.contents, app_url: @notification.app_url }}
    sample = ["id", "created_by", "headings", "contents", "app_url", "is_read", "read_at", "created_at", "updated_at", "accountable", "notification_type", "room_name", "user_type", "redirect", "sid", "type", "record_id", "notification_for", "profile_pic", "post_id"]
    expect(response).to have_http_status(201)
    expect(JSON.parse(response.body)['meta']['message']).to eq("Notification created.")
    expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
    end
  end


  context "when we create notification with Freezed account" do
    it 'Returns cannot create notification Please Unfreeze first' do
      token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @account.update(jwt_token: @account.jwt_token, freeze_account: true)
      post :create, params: { use_route: "/notifications/" , token: @token, id: @account.id , notification:{headings: @notification.headings, contents: @notification.contents,  app_url: @notification.app_url}}
      expect(JSON.parse(response.body)).to eq({"errors"=> {"message"=>"Account is Freezed. Please Unfreeze first"}})
    end
  end
end

describe 'GET show' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

context "when we show notification with correct params" do
  it 'Returns success' do
    get :show, params: {use_route: "/notifications/" , token: @token , id: @notification.id }
    sample = ["id", "created_by", "headings", "contents", "app_url", "is_read", "read_at", "created_at", "updated_at", "accountable", "notification_type", "room_name", "user_type", "redirect", "sid", "type", "record_id", "notification_for", "profile_pic", "post_id"]
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)['meta']['message']).to eq("Success.")
    expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(sample)
  end

  context "when we show notification with incorrect params" do
    it 'Returns Invalid token' do
    get :show, params: {use_route: "/notifications/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end

describe 'GET index' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when we list notification with correct params" do
    it 'Returns List of notifications.' do
    get :index, params: {use_route: "/notifications/" , token: @token }
    expect(response).to have_http_status(200)
    end
  end

  context "when we list notification with incorrect params" do
    it 'Returns Invalid token' do
    get :index, params: {use_route: "/notifications/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end

describe 'PATCH update' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end


context "when we update notification with correct params" do
  it 'Returns Notification marked as read.' do
    patch :update, params: {use_route: "/notifications/" , token: @token  , id: @notification.id , notification: { headings: "This is updated headings" , contents: "updated context", app_url: "updated url" } }
    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)['meta']['message']).to eq("Notification marked as read.")
    end
  end

  context "when we update notification with incorrect params" do
    it 'Returns Invalid token' do
    patch :update, params: {use_route: "/notifications/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end

describe 'DELETE destroy' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

context "when we destroy notification with correct params" do
  it 'Returns Deleted.' do
    delete :destroy, params: {use_route: "/notifications/" , token: @token  , id: @notification.id }
    expect(JSON.parse(response.body)["message"]).to eql("Deleted.")
    end
  end

  context "when we destroy notification with incorrect params" do
    it 'Returns Invalid token' do
    delete :destroy, params: {use_route: "/notifications/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end

describe 'PUT read_all' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when we pass correct params" do
    it 'Returns All notifications marked as read.' do
    put :read_all, params: {use_route: "/notifications/" , token: @token}
    expect(JSON.parse(response.body)["message"]).to eql("All notifications marked as read.")
    end
  end

  context "when we pass incorrect params" do
    it 'Returns Invalid token' do
    put :read_all, params: {use_route: "/notifications/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end

describe 'DELETE delete_all' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when we pass correct params" do
    it 'Returns All notifications deleted.' do
    delete :delete_all, params: {use_route: "/notifications/" , token: @token}
    expect(JSON.parse(response.body)["message"]).to eql("All notifications deleted.")
    end
  end

  context "when we pass incorrect params" do
    it 'Returns Invalid token' do
    delete :delete_all, params: {use_route: "/notifications/" , token: nil}
    expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
    end
  end
end
end

end
