require 'rails_helper'
require 'spec_helper'

RSpec.describe AccountBlock::TherapistController, type: :controller do
  let(:user) { create(:email_account, :with_user_role) }
  let(:therapist) { create(:email_account, :with_therapist_role) }
  let(:another_therapist) { create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist")) }
  let(:admin) { create(:admin_user) }
  let(:story) { create(:story, objectable: therapist) }
  let(:jwt_token) { SecureRandom.hex(4) }
  let(:skin_quiz) { create(:skin_quiz, question_type: "consultation") }
  let(:skin_quiz_1) { create(:skin_quiz, question_type: "skin_goal") }
  let(:choice_1) { create(:choice, skin_quiz: skin_quiz) }
  let(:choice_2) { create(:choice, skin_quiz: skin_quiz) }
  let(:account_choice_skin_quiz) { create(:account_choice_skin_quiz, skin_quiz: skin_quiz, account: user, choice: choice_1) }
  let(:skin_log_1) { create(:account_choice_skin_log, account: user, created_at: "31-05-2022", skin_quiz: skin_quiz, choice_ids: [choice_1.id]) }
  let(:skin_log_2) { create(:account_choice_skin_log, account: user, skin_quiz: skin_quiz, choice_ids: [choice_2.id]) }
  let(:skin_log_3) { create(:account_choice_skin_log, account: user, skin_quiz: skin_quiz_1, choice_ids: [choice_2.id]) }
  # let(:token) { BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now) }
  describe 'GET clients' do
    before(:each) do
      user && therapist
    end
    describe "user logged in" do
      it 'when id passed does not exist' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :clients, params: { id: 67, token: token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "User logged in" do
      it 'when id passed id correct' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :clients, params: { id: user.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(['Account is not associated to a therapist'])
      end
    end
    describe "Therapist logged in" do
      it 'Returns list of all the clients' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :clients, params: { id: therapist.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end
    describe "Therapist logged in and id passed does not belongs to logged in therapist" do
      it 'Returns error' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :clients, params: { id: another_therapist.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
  end


  describe 'GET weekly_skin_diary' do
    before(:each) do
      user && therapist
      @account = create(:account)
    end
    describe "user logged in" do
      it 'when id passed does not exist' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :weekly_skin_diary, params: { use_route: '/therapist', id: 67, token: token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "User logged in" do
      it 'when id passed id correct' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :weekly_skin_diary, params: {use_route: '/therapist', id: user.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(['Account is not associated to a therapist'])
      end
    end
    describe "Therapist logged in incorrect params" do
      it 'Returns Start date of week is not present.' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :weekly_skin_diary, params: {use_route: '/therapist' , token: token, id: therapist.id, client_id: user.id},as: :json
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Start date of week is not present.")
      end
    end

    describe "Therapist logged in" do
      it 'Returns list of weekly_skin_diary' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :weekly_skin_diary, params: {use_route: '/therapist' , token: token, id: therapist.id, client_id: user.id, start_date: Time.now},as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end
    describe "Therapist logged in and id passed does not belongs to logged in therapist" do
      it 'Returns error' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :weekly_skin_diary, params: {use_route: '/therapist', id: another_therapist.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
  end

  describe 'GET monthly_skin_diary' do
    before(:each) do
      user && therapist
    end
    describe "user logged in" do
      it 'when id passed does not exist' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :monthly_skin_diary, params: { use_route: '/therapist', id: 67, token: token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "User logged in" do
      it 'when id passed id correct' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :monthly_skin_diary, params: {use_route: '/therapist', id: user.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(['Account is not associated to a therapist'])
      end
    end
    describe "Therapist logged in" do
      it 'Returns list of all the clients' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :monthly_skin_diary, params: {use_route: '/therapist', id: therapist.id, client_id: user.id, token: token, year: "2021" , month: "2021-09"},as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end

    describe "Therapist logged in" do
      it 'Returns list of all the clients' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :monthly_skin_diary, params: {use_route: '/therapist', id: therapist.id, client_id: user.id, token: token},as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end
    describe "Therapist logged in and id passed does not belongs to logged in therapist" do
      it 'Returns error' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :monthly_skin_diary, params: {use_route: '/therapist', id: another_therapist.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
  end

  describe 'GET skin_logs' do
    before(:each) do
      user && therapist
    end
    describe "user logged in" do
      it 'when id passed does not exist' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :skin_logs, params: { use_route: '/therapist', id: 67, token: token }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "User logged in" do
      it 'when id passed id correct' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :skin_logs, params: {use_route: '/therapist', id: user.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(['Account is not associated to a therapist'])
      end
    end
    describe "Therapist logged in" do
      it 'Returns success' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_logs, params: {use_route: '/therapist', id: therapist.id, client_id: user.id, token: token, year: "2021"  },as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end

    describe "Therapist logged in" do
      it 'Returns success' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_logs, params: {use_route: '/therapist', id: therapist.id, client_id: user.id, token: token},as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end

    describe "Therapist logged in" do
      it "Returns Page doesn't exist" do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_logs, params: {use_route: '/therapist', id: therapist.id, client_id: user.id, token: token, page: 10},as: :json
        expect(response).to have_http_status(404)
      end
    end
    describe "Therapist logged in and id passed does not belongs to logged in therapist" do
      it 'Returns error' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_logs, params: {use_route: '/therapist', id: another_therapist.id, token: token }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
  end

    # describe 'GET skin_logs' do
    # before(:each) do
    #   user && therapist
    #   skin_journey = create(:skin_journey, therapist: therapist , account: user)
    # end
    # describe "user logged in" do
    #   it 'when id passed does not exist' do
    #     token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
    #     user.update(jwt_token: jwt_token)
    #     get :skin_journey, params: { use_route: '/therapist', token: token,data: { account_id: user.id, message: "test", before_image_url: "tets" , after_image_url: "tets" } }

    #     expect(response).to have_http_status(:not_found)
    #     expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
    #   end
    # end
    # describe "User logged in" do
    #   it 'when id passed id correct' do
    #     token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
    #     user.update(jwt_token: jwt_token)
    #     get :skin_journey, params: { use_route: '/therapist', token: token,data: { account_id: user.id, message: "test", before_image_url: "tets" , after_image_url: "tets" } }
    #     expect(response).to have_http_status(200)
    #     expect(JSON.parse(response.body)['errors']).to eql(['Account is not associated to a therapist'])
    #   end
    # end
    # describe "Therapist logged in" do
    #   it 'Returns success' do
    #     token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    #     therapist.update(jwt_token: jwt_token)
    #     get :skin_journey, params: { use_route: '/therapist', token: token,data: { account_id: user.id, message: "test", before_image_url: "tets" , after_image_url: "tets" } }
    #     expect(response).to have_http_status(200)
    #     # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
    #   end
    # end

    # describe "Therapist logged in" do
    #   before(:each) do
    #     user && therapist
    #     skin_journey = create(:skin_journey, therapist: therapist , account: user)
    #   end
    #   it 'Returns success' do
    #     token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    #     therapist.update(jwt_token: jwt_token)
    #     get :skin_journey, params: {use_route: '/skin_journey', token: token, data: { account_id: user.id, message: "message", before_image_url: "url", after_image_url: "url2" } }
    #     byebug
    #     expect(response).to have_http_status(200)
    #     # expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
    #   end
    # end

    # describe "Therapist logged in" do
    #   it "Returns Page doesn't exist" do
    #     token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    #     therapist.update(jwt_token: jwt_token)
    #     get :skin_journey, params: {use_route: '/therapist', id: therapist.id, client_id: user.id, token: token, page: 10},as: :json
    #     expect(response).to have_http_status(404)
    #     expect(JSON.parse(response.body)['errors']['message']).to eql(["Page doesn't exist"])
    #   end
    # end
  #   describe "Therapist logged in and id passed does not belongs to logged in therapist" do
  #     it 'Returns error' do
  #       token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
  #       therapist.update(jwt_token: jwt_token)
  #       get :skin_journey, params: { use_route: '/therapist', token: token,data: { account_id: user.id, message: "test", before_image_url: "tets" , after_image_url: "tets" } }
  #       expect(response).to have_http_status(200)
  #       expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
  #     end
  #   end
  # end


  describe 'PUT pin_clients' do
    before(:each) do
      user && therapist
    end
    describe "user" do
      it 'cannot pin clients' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        put :pin_clients, params: { token: token, client_ids: "[1,2,3]", id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :pin_clients, params: { token: token, client_ids: "[1,2,3]", id: another_therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error if id passed belongs to logged in therapist but client id does not exist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :pin_clients, params: { token: token, client_ids: "[1,2,3]", id: therapist.id }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error if id passed belongs to logged in therapist but client id does not exist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :pin_clients, params: { token: token, client_ids: "[#{user.id}]", id: therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['message']).to eql("Clients successfully pinned.")
        expect(JSON.parse(response.body)['accounts'].first['is_pinned']).to eql(true)
      end
    end
  end

  describe 'PUT unpin clients' do
    before(:each) do
      user && therapist
    end
    describe "user" do
      it 'cannot pin clients' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        put :unpin_clients, params: { token: token, client_ids: "[1,2,3]", id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :unpin_clients, params: { token: token, client_ids: "[1,2,3]", id: another_therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error if id passed belongs to logged in therapist but client id does not exist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :unpin_clients, params: { token: token, client_ids: "[1,2,3]", id: therapist.id }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error if id passed belongs to logged in therapist but client id does not exist' do
        user.update(is_pinned: false)
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :unpin_clients, params: { token: token, client_ids: "[#{user.id}]", id: therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['message']).to eql("Clients successfully unnnnpinned.")
        expect(JSON.parse(response.body)['accounts'].first['is_pinned']).to eql(false)
      end
    end
  end

  describe 'GET pinned clients' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get pinned clients list' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :pinned_clients, params: { token: token, id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :pinned_clients, params: { token: token, id: another_therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns success if id passed belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :pinned_clients, params: { token: token, id: therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['accounts'].first.keys).to match_array(["id", "email", "first_name"])
      end
    end
  end

  describe 'GET view_client_notes' do
    before(:each) do
      user && therapist
    end
    describe "user" do
      it 'cannot get client notes' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :view_client_notes, params: { token: token, id: user.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :view_client_notes, params: { token: token, id: another_therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      before do
        create(:therapist_note, account_id: user.id, therapist: therapist)
      end
      it 'Retuns success if id passed belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :view_client_notes, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['notes'].keys).to match_array(["id", "therapist_id", "account_id", "description", "created_at", "updated_at", "therapist_type"])
      end
    end
    describe "When Therapist logged in" do
      before do
        create(:therapist_note, account_id: user.id, therapist: therapist)
      end
      it 'Retuns empty if id passed belongs to logged in therapist but notes does not exist for client' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :view_client_notes, params: { token: token, id: therapist.id, client_id: 999 }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['notes']).to eql(nil)
      end
    end
  end

  describe 'GET update_client_notes' do
    before(:each) do
      user && therapist
    end
    describe "user" do
      it 'cannot update clients notes' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        put :update_client_notes, params: { token: token, data: { attributes: { account_id: user.id, description: "My description" } }, id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :update_client_notes, params: { token: token, data: { attributes: { account_id: user.id, description: "My description" } }, id: another_therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      before do
        create(:therapist_note, account_id: user.id, therapist: therapist)
      end
      it 'Retuns success if id passed belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :update_client_notes, params: { token: token, data: { attributes: { account_id: user.id, description: "My description" } }, id: therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['notes']['description']).to eql("My description")
      end
    end
    describe "When Therapist logged in" do
      it 'Creates new note if it does not exist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        put :update_client_notes, params: { token: token, data: { attributes: { account_id: user.id, description: "My description" } }, id: therapist.id }
        expect(response).to have_http_status(200)
        expect(AccountBlock::TherapistNote.count).to eql(1)
      end
    end
  end

  describe 'GET client_details' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get clients details' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :client_details, params: { token: token, id: user.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :client_details, params: { token: token, id: another_therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns success if id passed belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :client_details, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data']['id']).to eql("#{user.id}")
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error not found for incorrect client id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :client_details, params: { token: token, id: therapist.id, client_id: 999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
  end

  describe 'GET skin_diary' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get skin_diary' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :skin_diary, params: { token: token, id: user.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_diary, params: { token: token, id: another_therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      before do
        skin_log_1
      end
      it 'Retuns filtered log if date is passed along with params' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_diary, params: { token: token, id: therapist.id, client_id: user.id, date: "31-05-2022" }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data'].first['attributes']['id']).to eql(skin_log_1.id)
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error not found for incorrect client id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_diary, params: { token: token, id: therapist.id, client_id: 999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
     describe "When Therapist logged in" do
      before do
        skin_log_2
      end
      it 'Retuns latest log if date is not passed along with params' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_diary, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data'].first['attributes']['id']).to eql(skin_log_2.id)
      end
    end
  end

  describe 'GET consultation_form_show' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get consultation_form' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :consultation_form_show, params: { token: token, id: user.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :consultation_form_show, params: { token: token, id: another_therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns success if id passed belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :consultation_form_show, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
      end
    end
    describe "When Therapist logged in" do
      before do
        @skin_quiz_1 = skin_quiz
        @skin_quiz_2 = create(:skin_quiz, question_type: "skin_goal")
      end
      it 'Retuns only skin_quiz with consultation type questions' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :consultation_form_show, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data'].count).to eql(1)
      end
    end
     describe "When Therapist logged in" do
      it 'Retuns latest log if date is not passed along with params' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :consultation_form_show, params: { token: token, id: therapist.id, client_id: 999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
  end

  describe 'GET quiz_answer' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get quiz_answer' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :quiz_answer, params: { token: token, id: user.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :quiz_answer, params: { token: token, id: another_therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns latest log if date is not passed along with params' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :quiz_answer, params: { token: token, id: therapist.id, client_id: 999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "When Therapist logged in" do
      before do
        account_choice_skin_quiz
      end
      it 'Retuns error for id must present, if skin_quiz id is not passed' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :quiz_answer, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Skin quiz id must present")
      end
    end
    describe "When Therapist logged in" do
      before do
        account_choice_skin_quiz
      end
      it 'Retuns success only if skin_quiz id is present' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :quiz_answer, params: { token: token, id: therapist.id, client_id: user.id, skin_quiz_id: skin_quiz.id.to_i }
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['data']['answer']).to eql(choice_1.choice)
      end
    end
  end

  describe 'GET skin_goal_answers' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get skin_goal_answers' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :skin_goal_answers, params: { token: token, id: user.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_goal_answers, params: { token: token, id: another_therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error not found for incorrect client id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_goal_answers, params: { token: token, id: therapist.id, client_id: 999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "When Therapist logged in" do
      before do
        skin_log_3
      end
      it 'Retuns success response for correct client id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :skin_goal_answers, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data']).to eql(["#{account_choice_skin_quiz.choice.choice}"])
      end
    end
  end

  describe 'GET user_skin_goals' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get user_skin_goals' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :user_skin_goals, params: { token: token, id: user.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :user_skin_goals, params: { token: token, id: another_therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error not found for incorrect client id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :user_skin_goals, params: { token: token, id: therapist.id, client_id: 999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['errors']['message']).to eql("Record not found")
      end
    end
    describe "When Therapist logged in" do
      before do
        skin_log_3
      end
      it 'Retuns success response for correct client id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :user_skin_goals, params: { token: token, id: therapist.id, client_id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['data']['id']).to eql("#{skin_log_3.id}")
      end
    end
  end

  describe 'GET available_dates' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get available_dates' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :available_dates, params: { token: token, id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :available_dates, params: { token: token, id: another_therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      before do
        @acuity = BxBlockAppointmentManagement::AcuityController.new
        appointment_types = @acuity.appointment_types
        therapist.update(acuity_calendar: appointment_types&.first['calendarIDs'].first)
        @calendar_id = appointment_types&.first['id']
        dates = []
        day = Time.now.day
        last_day = Time.now.last_day_of_month
        count = 1
        while (day < last_day) do
          dates.push({'date'=> count.days.from_now.strftime("%Y-%m-%d")})
          count = count + 1
          day = day + 1
        end
        @response_sample = { "available_dates"=> dates}
      end
      it 'Retuns success response for correct therapist id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :available_dates, params: { token: token, id: therapist.id, appointmentTypeID: @calendar_id, month: Time.now.strftime("%Y-%m") },as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)).to eql(@response_sample)
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error for incorrect appointmentTypeID param' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :available_dates, params: { token: token, id: therapist.id, appointmentTypeID: 1234567, month: Time.now.strftime("%Y-%m") }
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['available_dates']['message']).to eql("The appointment type \"1234567\" does not exist.")
      end
    end
  end

  describe 'GET available_times' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get available_times' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :available_times, params: { token: token, id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :available_times, params: { token: token, id: another_therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    describe "When Therapist logged in" do
      before do
        @acuity = BxBlockAppointmentManagement::AcuityController.new
        appointment_types = @acuity.appointment_types
        therapist.update(acuity_calendar: appointment_types&.first['calendarIDs'].first)
        @calendar_id = appointment_types&.first['id']
      end
      it 'Retuns success response for correct therapist id' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :available_times, params: { token: token, id: therapist.id, appointmentTypeID: @calendar_id, date: 1.days.from_now.strftime("%Y-%m-%d") },as:  :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)["available_times"].count).to eql(16)
      end
    end
    describe "When Therapist logged in" do
      it 'Retuns error for incorrect appointmentTypeID param' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :available_times, params: { token: token, id: therapist.id, appointmentTypeID: 1234567, month: Time.now.strftime("%Y-%m") }
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['available_times']['message']).to eql("The appointment type \"1234567\" does not exist.")
      end
    end
  end

  describe 'GET apppointments_list' do
    before(:each) do
      user.update(is_pinned: true) && therapist
    end
    describe "user" do
      it 'cannot get apppointments_list' do
        token = BuilderJsonWebToken.encode(user.id, {jwt_token: jwt_token, account_type: user.type}, 1.year.from_now)
        user.update(jwt_token: jwt_token)
        get :apppointments_list, params: { token: token, id: user.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({"errors"=> ['Account is not associated to a therapist']})
      end
    end
    describe "When Therapist logged in" do
      before do
        another_therapist = create(:email_account, role: BxBlockRolesPermissions::Role.find_by(name: "Therapist"))
      end
      it 'Retuns error if id passed does not belongs to logged in therapist' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :apppointments_list, params: { token: token, id: another_therapist.id }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)['errors']).to eql(["details does not belongs to this therapist"])
      end
    end
    # describe "When Therapist logged in" do
    #   before do
    #     @acuity = BxBlockAppointmentManagement::AcuityController.new
    #     @appointment_types = @acuity.appointment_types
    #     therapist.update(acuity_calendar: @appointment_types&.second['calendarIDs'].first)
    #     @calendar_id = @appointment_types&.second['id']
    #     @times = @acuity.available_times(therapist.acuity_calendar, @calendar_id, 1.day.from_now.strftime("%Y-%m-%d"))
    #     @params = {datetime: @times.first['time'], appointmentTypeID: @calendar_id, firstName: "Test", lastName: "Name", email: " @yopmail.com", calendarID: @appointment_types&.first['calendarIDs'].first, phone: "1234567898", age: 34, address: "XYZ street", transaction_id: "ch_3LUrQ6AKbFHrnwJ41OMMTWvz"}
    #     # @appointment = @acuity.create(@params)
    #   end
    #   it 'Retuns success response for correct therapist id' do
    #     token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
    #     therapist.update(jwt_token: jwt_token)
    #     get :apppointments_list, params: { token: token, id: therapist.id, minDate: 2.day.ago.strftime("%Y/%m/%d"), maxDate: 1.days.from_now.strftime("%Y/%m/%d") }
    #     expect(response).to have_http_status(200)
    #     # response_sample = ["id", "firstName", "lastName", "phone", "email", "date", "time", "endTime", "dateCreated", "datetimeCreated", "datetime", "price", "priceSold", "paid", "amountPaid", "type", "appointmentTypeID", "classID", "addonIDs", "category", "duration", "calendar", "calendarID", "certificate", "confirmationPage", "location", "notes", "timezone", "calendarTimezone", "canceled", "canClientCancel", "canClientReschedule", "labels", "forms", "formsText", "startVideo"]
    #     # expect(JSON.parse(response.body)['appointments'].first.keys).to match_array(response_sample)
    #   end
    # end
    describe "When Therapist logged in" do
      it 'Retuns empty array for incorrect appointmentTypeID param' do
        token = BuilderJsonWebToken.encode(therapist.id, {jwt_token: jwt_token, account_type: therapist.type}, 1.year.from_now)
        therapist.update(jwt_token: jwt_token)
        get :apppointments_list, params: { token: token, id: therapist.id, appointmentTypeID: 1234567, month: Time.now.strftime("%Y-%m") },as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)['apppointments']).to eql([])
      end
    end
  end

end
