require 'rails_helper'
require 'spec_helper'

RSpec.describe AccountBlock::StoryController, type: :controller do
  let(:user) { create(:email_account, :with_user_role) }
  let(:therapist) { create(:email_account, :with_therapist_role) }
  let(:admin) { create(:admin_user) }
  let(:story) { create(:story, objectable: therapist) }
  let(:jwt_token) { SecureRandom.hex(4) }
  # let(:token) { BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now) }
  describe 'POST create' do
    before(:each) do
      user && therapist
    end
    describe "user" do
      it 'cannot create story' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        post :create, params: { data: { attributes: { target: "all_users", video: "/spec/support/assets/1.mp4"  } }, token: token }
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist or an admin']})
      end
    end
    describe "Therapist with freeze account" do
      it 'cannot create story' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token, freeze_account: true)
        post :create, params: { data: { attributes: { target: "all_users", video: "/spec/support/assets/1.mp4"  } }, token: token }
        expect(JSON.parse(response.body)).to eq({"errors"=> {"message"=>"Account is Freezed. Please Unfreeze first"}})
      end
    end
    describe "Therapist with Unfreeze account" do
      it 'can create story successfully' do
        therapist.update(jwt_token: jwt_token)
        video = Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.mp4'), 'video/mp4')
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        post :create, params: { data: { attributes: { target: "all_users", video: video  } }, token: token }
        response_data = AccountBlock::StoriesSerializer.new(therapist.stories.first, params: {current_user: therapist}).serializable_hash
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      user && therapist
    end
    describe "user" do
      it 'cannot delete story' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        delete :destroy, params: { id: 1, token: token }
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist or an admin']})
      end
    end
    describe "Therapist with freeze account" do
      it 'cannot delete story' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token, freeze_account: true)
        delete :destroy, params: { id: 1, token: token }
        expect(JSON.parse(response.body)).to eq({"errors"=> {"message"=>"Account is Freezed. Please Unfreeze first"}})
      end
    end
    describe "when pass incorrect id" do
      it 'Returns not found' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        delete :destroy, params: { id: 555, token: token }
        expect(response).to have_http_status(:not_found)
      end
    end
    describe "when pass correct id" do
      before do
        @story = create(:story, objectable: therapist)
      end
      it 'successfully deletes story' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        delete :destroy, params: { id: @story.id, token: token }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET show' do
    before(:each) do
      user.update(freeze_account: false) && therapist && admin && story
    end
    describe "user" do
      it 'can view story' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :show, params: { id: story.id, token: token }
        expect(response).to have_http_status(200)
      end
    end
    describe "user" do
      it 'update the view count for story' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :show, params: { id: story.id, token: token }
        expect(response).to have_http_status(200)
        expect(AccountBlock::StoryView.first.accountable).to eql(user)
      end
    end
    describe "therapist" do
      it 'will not update the view count for story' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :show, params: { id: story.id, token: token }
        expect(response).to have_http_status(200)
        expect(AccountBlock::StoryView.all.to_a).to eql([])
      end
    end
    describe "incorrect id" do
      it 'Returns NOT found' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :show, params: { id: 777, token: token }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

    describe 'GET my_stories' do
    before(:each) do
      user.update(freeze_account: false) && therapist && admin && story
    end
    describe "user" do
      it 'cannot view story' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :my_stories, params: { token: token }
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist or an admin']})
      end
    end
    describe "therapist" do
      it 'can view story' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :my_stories, params: { token: token }
        expect(response).to have_http_status(200)
      end
    end
  end

end
