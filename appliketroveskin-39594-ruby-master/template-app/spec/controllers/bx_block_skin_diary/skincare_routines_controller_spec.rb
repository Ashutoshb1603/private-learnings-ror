require 'rails_helper'
RSpec.describe BxBlockSkinDiary::SkincareRoutinesController, type: :controller do
  let(:user) { create(:email_account, :with_user_role) }
  let(:therapist) { create(:email_account, :with_therapist_role) }
  let(:jwt_token) { SecureRandom.hex(4) }

describe 'POST create' do
    before(:each) do
    @user = user
    @therapist = therapist
    @skincare_routine = create(:skincare_routine , therapist: @therapist, account: @user)
    @skincare_step = create(:skincare_step, skincare_routine: @skincare_routine)
    @skincare_product = create(:skincare_product, skincare_step: @skincare_step)
    end
    describe "User logged in" do
      it 'when id passed id correct' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        post :create, params: { id: user.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(['Account is not associated to a therapist'])
      end
    end
    describe "Therapist logged in" do
      it 'Returns created Routines' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        params = { id: @therapist.id, token: token  , skincare_routine: {account_id: @user.id , routine_type: 1, note: "New note"} }
        post :create, params: params, as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end

    describe "Therapist logged incorrect token" do
      it 'Returns Invalid token' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        post :create, params: { id: therapist.id, token: nil }
        expect(JSON.parse(response.body)['errors']['message']).to eql("Invalid token")
      end
    end

    describe "Therapist logged correct params" do
      it 'Returns success' do
        @user = user
        @skincare_routine = create(:skincare_routine, account: @user, therapist: @therapist)
        @skincare_product = create(:skincare_product, skincare_step: @skincare_step, product_id: "7549054517467")
        @skincare_step = create(:skincare_step, skincare_routine: @skincare_routine)
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        post :create, params: {token: token, skincare_routine: { account_id: @user.id, routine_type: 1, note: "abcde", skincare_steps_attributes: [ {  steps: "step 1 updated" } ], skincare_products_attributes: [{  name: "Product name", product_id: "7549054517467", image_url: "image url" }] } },as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors']['message']).to eql("Invalid token")
      end
    end
end



describe 'GET index' do
    before(:each) do
    @user = user
    @therapist = therapist
    @skincare_routine = create(:skincare_routine, account: @user, therapist: @therapist)
    @skincare_step = create(:skincare_step, skincare_routine: @skincare_routine)
    @skincare_product = create(:skincare_product, skincare_step: @skincare_step)
    @token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    therapist.update(jwt_token: jwt_token)
    end
    describe "therapist logged in"
      context "when account_id is not passed in params" do
        it 'Returns empty list' do
          get :index, params: { token: @token, skincare_routine_id: @skincare_routine.id , account_id: @user.id , therapist_id: @therapist.id}, as: :json
          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)['data']).to match_array([])
        end
      end
     context "when we pass account_id in params" do
        it 'Returns data list' do
          get :index, params: { token: @token, id: @skincare_product.id}

          expect(response).to have_http_status(200)
          expect(JSON.parse(response.body)['data']).to match_array([])
        end
      end
      context "when token is not passed in params" do
        it 'Returns Invalid token' do
          get :index, params: { token: @token1 , account_id: @user.id  }
          expect(response).to have_http_status(400)
          expect(JSON.parse(response.body)['errors']['message']).to eql("Invalid token")
        end
      end
end

describe 'PUT update' do
    before(:each) do
    @user = user
    @therapist = therapist
    @token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    therapist.update(jwt_token: jwt_token)
    end
    describe "therapist logged in"
      context "when update  skincare routine with correct params" do
        it 'Returns success' do
          @skincare_routine = create(:skincare_routine , therapist: @therapist, account: @user)
          @skincare_step = create(:skincare_step, skincare_routine: @skincare_routine)
          @skincare_product = create(:skincare_product, skincare_step: @skincare_step, product_id: "7549054517467")
          put :update, params: {use_route: "/skincare_routines/", token: @token, id: @skincare_routine.id, skincare_routine: { skincare_products_attributes: [{ id: @therapist.id, name: "Productsdf eff2", product_id: @skincare_product.id, image_url: "123456" }] } }
          expect(response).to have_http_status(200)
        end
      end
end

describe 'PUT remove_note' do
    before(:each) do
    @user = user
    @therapist = therapist
    @token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    therapist.update(jwt_token: jwt_token)
    end
    describe "therapist logged in"
      context "when remove_product passed correct params" do
        it 'Returns Deleted succesfully!' do
        @skincare_routine = create(:skincare_routine , therapist: @therapist, account: @user)
        @skincare_step = create(:skincare_step, skincare_routine: @skincare_routine)
        @skincare_product = create(:skincare_product, skincare_step: @skincare_step)
        put :remove_note, params: {use_route: "/skincare_routines/", token: @token, id: @skincare_product.id}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors'] ['message']).to eql("Deleted succesfully!")
        end
      end
end

describe 'GET get_routines' do
    before(:each) do
    @user = user
    @therapist = therapist
    @skincare_routine = create(:skincare_routine , therapist: @therapist, account: @user)
    @skincare_step = create(:skincare_step, skincare_routine: @skincare_routine)
    @skincare_product = create(:skincare_product, skincare_step: @skincare_step)
    @token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    therapist.update(jwt_token: jwt_token)
    end
    describe "therapist logged in"
      context "when get_routines correct params" do
        it 'Returns success' do
        get :get_routines, params: {use_route: "/skincare_routines/", token: @token, id: @skincare_product.id}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors'] ['message']).to eql("Deleted succesfully!")
        end
      end
end

describe 'DELETE remove_product' do
    before(:each) do
    @user = user
    @therapist = therapist
    @token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    therapist.update(jwt_token: jwt_token)
    end
    describe "therapist logged in"
      context "when get_routines correct params" do
        it 'Returns success' do
        @skincare_routine = create(:skincare_routine , therapist: @therapist, account: @user)
        @skincare_step = create(:skincare_step, skincare_routine: @skincare_routine)
        @skincare_product = create(:skincare_product, skincare_step: @skincare_step)
        delete :remove_product, params: {use_route: "/skincare_routines/", token: @token, id: @skincare_product.id}
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['errors'] ['message']).to eql("Deleted succesfully!")
        end
      end

    describe "therapist logged in"
      context "when remove_product incorrect params" do
        it 'Returns unprocessable_entity' do
        @skincare_routine = build_stubbed(:skincare_routine , therapist: @therapist, account: @user)
        @skincare_step = build_stubbed(:skincare_step, skincare_routine: @skincare_routine)
        @skincare_product = build_stubbed(:skincare_product, skincare_step: @skincare_step)
        delete :remove_product, params: {use_route: "/skincare_routines/", token: @token, id: @skincare_product.id}
        expect(response).to have_http_status(422)
        # expect(JSON.parse(response.body)['errors'] ['message']).to eql("Deleted succesfully!")
        end
      end
end
end
