require 'rails_helper'

RSpec.describe BxBlockHiddenPlaces::HiddenPlacesController, type: :controller do
    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:activity) {BxBlockCategories::Activity.create(name: "swim", status: "approved", account_id: user.id) }
    let(:travel_item) { BxBlockCategories::TravelItem.create(name: "knife", account_id: user.id) }
    let(:weather) { BxBlockCategories::Weather.create!(name: "winter", account_id: user.id) }
    let(:hidden_place) {BxBlockHiddenPlaces::HiddenPlace.create!(hidden_place_valid_params)}
    let(:images) { [ file1, file2 ] }
    let(:user) { FactoryBot.create(:Account)}
    let(:create_hidden_place) { create(:hidden_place, account_id: user.id) }
    
    before :each do
        @request.headers[:token] =  BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')
    end

    let(:hidden_place_valid_params) do
        {   
            account_id: user.id,
            place_name: Faker::Name.name,
            google_map_link: "www.example.com",
            description: "test description for spec",
            latitude: 20.2343,
            longitude: 67.34534,
            activity_ids: [activity.id],
            travel_item_ids: [travel_item.id],
            weather_ids: [weather.id],
            images: images
        }
    end

    describe "Create Action" do
        context "creates a hidden place" do
            it "creates hidden place with valid params" do
                post :create, params: { data: hidden_place_valid_params }
                expect(response).to have_http_status(:created)
                expect(BxBlockHiddenPlaces::HiddenPlace.count).to eq 1
            end
        end
    end

    describe "Update Hidden place" do
        context "Update place details" do
            it "Update hidden place with valid params" do
                put :update, params: { id: create_hidden_place.id, data: hidden_place_valid_params }
                expect(response).to have_http_status(:ok)
                expect(BxBlockHiddenPlaces::HiddenPlace.count).to eq 1
            end

            it "validate hidden place with valid params" do
                put :update, params: { id: create_hidden_place.id, data: hidden_place_valid_params }
                expect(response).to have_http_status(:ok)
                expect(create_hidden_place.place_name).to eq ('Test')
            end

            it "validate hidden place details" do
                put :update, params: { id: create_hidden_place.id, data: hidden_place_valid_params }
                expect(response).to have_http_status(:ok)
                expect(create_hidden_place.latitude).not_to be_nil
            end
        end
    end

    describe "Not Update Hidden place" do
        context "Should not Update hidden place without id" do
            it 'Invalid place' do
                put :update, params: { id: 10, data: hidden_place_valid_params } 
                expect(response).to have_http_status(:unprocessable_entity)
           end

           it 'Invalid user' do
                @request.headers[:token] = nil
                put :update, params: { id: 10, data: hidden_place_valid_params } 
                expect(response).to have_http_status(:bad_request)
                expect(JSON.parse(response.body)['errors']).to eq ([{"token"=>"Invalid token"}])
           end
        end
    end

    describe 'Events around the place' do
        context 'Get Event around place' do
            it 'get events' do
                get :events_around_the_place, params: {hidden_place_id: create_hidden_place.id}
                expect(response).to have_http_status(:ok)
            end

            it 'get events by guest user' do
                get :events_around_the_place, params: {hidden_place_id: create_hidden_place.id}
                expect(response).to have_http_status(:ok)
            end
        end
    end

    describe 'Destroy place' do
        context 'destroy valid place' do
            it 'destroy place' do
                delete :destroy, params: {id: create_hidden_place.id}
                expect(response).to have_http_status(:ok)
            end

            it 'should not allow delete if no token' do
                @request.headers[:token] = nil
                get :destroy, params: {id: create_hidden_place.id}
                expect(response).to have_http_status(400)
            end

            it 'should not allow delete if id not valid' do
                @request.headers[:token] = nil
                get :destroy, params: {id: 122}
                expect(response).to have_http_status(400)
            end
        end
    end
end