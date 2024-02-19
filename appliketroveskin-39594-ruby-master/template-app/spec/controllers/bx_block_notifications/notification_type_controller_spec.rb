require 'rails_helper'
RSpec.describe BxBlockNotifications::NotificationTypesController, type: :controller do

describe 'GET index' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @notification_type = create(:notification_type)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns notification type show' do
      get :index, params: { use_route: "/notifications/" , token: @token, id: @account.id , notification:{headings: @notification.headings, contents: @notification.contents, app_url: @notification.app_url }}
      expect(response).to have_http_status(200)
    end
  end
end

describe 'POST enable_or_disable' do
  before do
    @account = create(:account , freeze_account: false)
    @notification = create(:notification, accountable: @account)
    @notific_type = create(:notification_type)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns notification type show' do
      post :enable_or_disable, params: { use_route: "/notifications/" , token: @token, id: @notific_type.id , notification:{headings: @notification.headings, contents: @notification.contents, app_url: @notification.app_url }}
      expect(response).to have_http_status(200)
    end
  end
end

end
