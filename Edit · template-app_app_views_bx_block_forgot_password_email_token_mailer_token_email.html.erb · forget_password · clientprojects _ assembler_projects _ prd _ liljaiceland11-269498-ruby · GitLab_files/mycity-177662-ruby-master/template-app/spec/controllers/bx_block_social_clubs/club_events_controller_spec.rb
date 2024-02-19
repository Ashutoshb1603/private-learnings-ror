require 'rails_helper'

RSpec.describe BxBlockSocialClubs::ClubEventsController, type: :controller do
    # let(:file1) { Rack::Test::UploadedFile.new('spec/support/assets/tree.jpg', 'image/jpg')}
    # let(:file2) { Rack::Test::UploadedFile.new('spec/support/assets/gateway.jpeg', 'image/jpeg')}

    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:user) { AccountBlock::Account.create!(full_name: "manoj", email: "k.manojkumar369@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
    let(:user1) { AccountBlock::Account.create!(full_name: "siva", email: "siva@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
    let(:interest1) {BxBlockInterests::Interest.create(name: "tree", icon: file1)}
    let(:interest2) {BxBlockInterests::Interest.create(name: "gate", icon: file2)}

    let(:images) { [ file1, file2 ] }

    let(:social_club_params) do
        {   account_id: user.id,
            name: "Environment",
            description: "BlIjoibG9naW4ifQ.-chcl9_AARK7Fc4g. ",
            community_rules: "1.add, 2.diff",
            location: "sdfsaaaa",
            is_visible: false,
            user_capacity: 10,
            chat_channels: [1, 2],
            images: images,
            interest_ids: [interest1.id, interest2.id],
            bank_name: "Arab bank",
            bank_account_name: "manoj",
            bank_account_number: "123456765422",
            routing_code: "sdfsf",
            max_channel_count: 10,
            fee_amount_cents: 10,
            status: "approved"
        }
    end

    let(:social_club) { BxBlockSocialClubs::SocialClub.create!(social_club_params)}

    let(:activity1) { BxBlockCategories::Activity.create(name: "singing", status: "approved") }
    let(:activity2) {BxBlockCategories::Activity.create(name: "musical", status: "approved") }
    let(:travel_item) { BxBlockCategories::TravelItem.create(name: Faker::Name.name, account_id: user.id) }

    let(:event_valid_params) do
        {   social_club_id: social_club.id,
            event_name: "volunteer", 
            location: "12.23534645",
            start_date_and_time: "17/11/2022", 
            end_date_and_time: "18/11/2022",
            description: "Building Block creation",
            start_time: "10:00:45",
            end_time: "13:00:55",
            images: images,
            activity_ids: [activity1.id, activity2.id],
            travel_item_ids: [travel_item.id, travel_item.id],
            max_participants: 100,
            age_should_be: 44,
            is_visible: false,
            fee_amount_cents: 75.20,
            status: "approved"
        }
    end

    let(:event_invalid_params) { event_valid_params.merge!({ event_name: "" })}
    
    let(:event) { BxBlockClubEvents::ClubEvent.create!(event_valid_params)}

    let(:approved_event_params) { valid_params.merge!({ status: "approved" })}
    let(:approved_event) { BxBlockClubEvents::ClubEvent.create!(approved_event_params)}
    let(:token) {BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')}

    context "Index Action" do
        it "should returns all the approved events " do
            event
            total = BxBlockClubEvents::ClubEvent.approved.count
            get :index, params: { social_club_id: social_club.id }
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body).size).to eq(1)       
        end
    end

    describe "Create Action" do
        context "Create new event with invalid attributes" do
            it "should return validation errors" do
                @request.headers[:token] =  token
                post :create, params: { social_club_id: social_club.id, data: { attributes: event_invalid_params } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context "Create new evnt with valid attributes" do
            it "should create a new event with given attributes" do
                @request.headers[:token] =  token
                post :create, params: { social_club_id: social_club.id, data: { attributes: event_valid_params } }
                expect(response).to have_http_status(:created)
                expect(BxBlockClubEvents::ClubEvent.count).to eq 1
            end        
        end
    end

    describe "Show Action" do
        context "Fetch an existing event" do
            it "should fetch event with given ID" do
                @request.headers[:token] =  token
                get :show, params: { social_club_id: social_club.id, id: event.id }
                expect(response).to have_http_status(:ok)
            end
        end

        context "Fetch a non-existing event" do
            it "should throw not found error" do
                @request.headers[:token] =  token
                get :show, params: { social_club_id: social_club.id, id: 143 }
                expect(response).to have_http_status(:not_found)
            end
        end
    end

    describe "Update Action" do
        context "update an existing event" do
            it "should update event with given ID" do
                @request.headers[:token] =  token
                put :update, params: { social_club_id: social_club.id, id: event.id, data: { attributes: { description: "description1", age_should_be: 18 } } }
                expect(response).to have_http_status(:ok)
            end
        end

        context "update a event with invalid attributes" do
            it "should throw error" do
                @request.headers[:token] =  token
                put :update, params: { social_club_id: social_club.id, id: event.id, data: { attributes: { description: "", age_should_be: ""} } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context "update a non-existing event" do
            it "should throw not found error" do
                @request.headers[:token] =  token
                put :update, params: { social_club_id: social_club.id, id: 1911, data: { attributes: { description: "description1", age_should_be: 18} } }
                expect(response).to have_http_status(:not_found)
            end
        end

        context "should not allow to update another user" do
            it "should return invalid social club" do
                @request.headers[:token] =  BuilderJsonWebToken.encode(user1.id, 10.minutes.from_now, token_type: 'login')
                put :update, params: { social_club_id: social_club.id, id: 1911, data: { attributes: { description: "description1", age_should_be: 18} } }
                expect(response).to have_http_status(:not_found)
            end

            it "should return invalid event" do
                @request.headers[:token] =  token
                put :update, params: { social_club_id: social_club.id, id: 1912, data: { attributes: { description: "description1", age_should_be: 18} } }
                expect(response).to have_http_status(:not_found)
            end
        end
    end

    describe "Destroy Action" do
        context "delete an existing event" do
            it "should delete event with given ID" do
                @request.headers[:token] =  token
                delete :destroy, params: { social_club_id: social_club.id, id: event.id }
                expect(response).to have_http_status(:ok)
            end

            it "should throw an error with given ID" do
                @request.headers[:token] =  token
                delete :destroy, params: { social_club_id: social_club.id, id: event.id }
                expect(response).to have_http_status(:ok)
            end
        end

        context "should not allow to destroy another user" do
            it "should return invalid social club" do
                @request.headers[:token] =  BuilderJsonWebToken.encode(user1.id, 10.minutes.from_now, token_type: 'login')
                delete :destroy, params: { social_club_id: social_club.id, id: 1911, data: { attributes: { description: "description1", age_should_be: 18} } }
                expect(response).to have_http_status(:not_found)
            end

            it "should return invalid event" do
                @request.headers[:token] =  token
                delete :destroy, params: { social_club_id: social_club.id, id: 1912, data: { attributes: { description: "description1", age_should_be: 18} } }
                expect(response).to have_http_status(:not_found)
            end
        end
    end

    describe "Upcoming events" do 
        context "returns all upcoming events of my social clubs" do
            it "should retrun all events of current user" do
                event
                @request.headers[:token] =  token
                get :upcoming_events
                expect(response).to have_http_status(:ok)
            end

            it "should retrun upcoming events of guest user" do
                event
                @request.headers[:token] = nil
                get :upcoming_events
                expect(response).to have_http_status(:ok)
                expect(JSON.parse(response.body)['message']).to eq ("No upcoming events")
            end
        end
    end

    describe "search events by location" do 
        context "returns all nearby events" do
            it "should retrun nearby events" do
                @request.headers[:token] =  token
                get :upcoming_events, params: {event_id: event.id}
                expect(response).to have_http_status(:ok)
            end
        end
    end

    describe "search events by params" do
        context "search events" do
            it "should return event with activity id" do
                event
                @request.headers[:token] =  token
                get :search_events_by_params, params: {activity_id: activity1.id}
                expect(response).to have_http_status(:ok)
            end

            it "should return event with travel item id" do
                event
                @request.headers[:token] =  token
                get :search_events_by_params, params: {travel_item_id: travel_item.id}
                expect(response).to have_http_status(:ok)
            end
        end
    end
end
