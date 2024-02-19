require 'rails_helper'
RSpec.describe BxBlockEvent::EventsController, type: :controller do
 let(:user) { create(:email_account, :with_user_role) }
 let(:jwt_token) { SecureRandom.hex(4) }


describe 'POST create' do
    before(:each) do
      @user = user
    end
    describe "user logged in with correct params" do
      it 'Returns create event' do
        token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
        @user.update(jwt_token:@user.jwt_token)
        post :create, params: {id:@user.id, token: token , user_event: {event_date: "19/07/1998" , life_event_id: 1, account_id: 1 }}
        expect(response).to have_http_status(201)
        # expect(JSON.parse(response.body)['data'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end
  end

describe 'GET index' do
    before(:each) do
      @user = user
    end
    describe "when we list all event with correct params" do
      it 'Returns success' do
        token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
        @user.update(jwt_token:@user.jwt_token)
        get :index, params: {use_route: '/events/' , token: token }
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['data'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end
  end


describe 'GET life_events' do
    before(:each) do
      @user = user
    end
    describe "when we list all event with correct params" do
      it 'Returns success' do
        token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
        @user.update(jwt_token:@user.jwt_token)
        get :life_events, params: {use_route: '/events/' , token: token }
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['data'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end
  end


describe 'DELETE delete_event' do
    before(:each) do
      @user = user
    end
    describe "when we user delete event with correct params" do
      let(:life_event) { create(:life_event) }
      let(:user_event) { create(:user_event, life_event: life_event, account: @user) }
      it 'Returns Event deleted successfully' do
        token = BuilderJsonWebToken.encode(@user.id, {jwt_token: @user.jwt_token, account_type: @user.type}, 1.year.from_now)
        @user.update(jwt_token:@user.jwt_token)
        delete :delete_event, params: {use_route: '/events/' , token: token, id: user_event.id}
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['message']).to eql("Event deleted successfully")
      end
    end
  end

end


