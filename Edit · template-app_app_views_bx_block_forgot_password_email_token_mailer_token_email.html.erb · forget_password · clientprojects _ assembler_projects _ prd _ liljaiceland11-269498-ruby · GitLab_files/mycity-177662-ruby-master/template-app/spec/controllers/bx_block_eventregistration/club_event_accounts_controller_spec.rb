require 'rails_helper'

RSpec.describe BxBlockEventregistration::ClubEventAccountsController, type: :controller do
  let(:user) { AccountBlock::Account.create!(full_name: "dsfdfdsf", password: "12345678", user_name: "dfdfdsfs", email: Faker::Internet.safe_email) }
  let(:club_event) { create(:club_event) }
  let(:account_social_club) {BxBlockSocialClubs::AccountSocialClub.create(social_club_id: club_event.social_club_id, account_id: user.id)}
  let(:club_event_account) {BxBlockEventregistration::ClubEventAccount.create!(club_event_id: club_event.id, account_id: user.id)}

  before :each do
    @request.headers[:token] =  BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')
  end

  describe "Create Action" do
    context "Create new event with invalid attributes" do
      it "should return validation errors" do
        post :create, { params: {account_id: user.id} }
        expect(response).to have_http_status(:unprocessable_entity)
      end        
    end

    context "Create new event registration with valid attributes" do
      before :each do
        club_event
        account_social_club
      end

      it "should create a new event registration with given attributes" do
        club_event.update(end_date_and_time: (Time.now + 5.day))
        post :create, { params: {event_id: club_event.id, account_id: user.id} }
        expect(response).to have_http_status(:created)
        expect(BxBlockEventregistration::ClubEventAccount.count).to eq 1
      end

      it 'should not allow to register for past event' do
        post :create, { params: {event_id: club_event.id, account_id: user.id} }
        expect(response).to have_http_status(:not_found)
      end

      it 'should allow to register for today last day event' do
        club_event.update(end_date_and_time: (Time.now.end_of_day))
        post :create, { params: {event_id: club_event.id, account_id: user.id} }
        expect(response).to have_http_status(:created)
      end

    end
  end

  context "Index Action" do
    it "should returns all the events" do
      club_event_account
      get :index, params: {event_id: club_event.id}
      expect(response).to have_http_status(:ok)
    end
  end

  context 'my tickets' do
    it 'should return all past stories' do
      club_event_account
      club_event.images.destroy_all
      get :my_tickets, params: {type: 'past'}
      expect(response).to have_http_status(:ok)
    end

    it 'should return all active stories' do
      club_event_account
      club_event.images.destroy_all
      get :my_tickets, params: {type: 'active'}
      expect(response).to have_http_status(:ok)
    end
  end

  context 'ticket details' do
    it 'should return ticket details' do
      club_event_account
      club_event.images.destroy_all
      get :ticket_details, params: {club_event_id: club_event.id}
      expect(response).to have_http_status(:ok)
    end
  end

end