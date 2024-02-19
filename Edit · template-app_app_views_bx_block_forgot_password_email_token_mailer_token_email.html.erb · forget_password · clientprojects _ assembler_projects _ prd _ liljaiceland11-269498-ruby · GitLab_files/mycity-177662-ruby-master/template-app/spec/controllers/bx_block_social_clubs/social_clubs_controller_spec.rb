require 'rails_helper'

RSpec.describe BxBlockSocialClubs::SocialClubsController, type: :controller do
    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:user) { AccountBlock::Account.create!(full_name: "manoj", email: "k.manojkumar369@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
    let(:interest1) {BxBlockInterests::Interest.create(name: "tree", icon: file1)}
    let(:interest2) {BxBlockInterests::Interest.create(name: "gate", icon: file2)}
    let(:images) { [ file1, file2 ] }
    let(:valid_params) do        
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
            status: "draft"
        }
    end
    

    let(:social_club1) { BxBlockSocialClubs::SocialClub.create!(valid_params)}

    let(:invalid_params) { valid_params.merge!({ name: "" })}

    let(:status_approved) { valid_params.merge!({ status: "approved" })}
    let(:social_club2) { BxBlockSocialClubs::SocialClub.create!(status_approved)}

    let(:token) {BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')}
    ActiveJob::Base.queue_adapter = :test

    describe "Create Action" do
        context "Create new social club with invalid attributes" do
            it "should return validation errors" do
                @request.headers[:token] =  token
                post :create, { params: { data: { attributes: invalid_params } } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context "Create new social_club with valid attributes" do
            it "should create a new social club with given attributes" do
                @request.headers[:token] =  token
                post :create, { params: { data: { attributes: valid_params } } }
                expect(response).to have_http_status(:created)
                expect(BxBlockSocialClubs::SocialClub.count).to eq 1
            end

            it "should create a new social club with enqueued chat creation job" do
                @request.headers[:token] =  token
                expect {
                    post :create, { params: { data: { attributes: valid_params } } }
                }.to have_enqueued_job(BxBlockSocialClubs::CreateChatJob)
            end                
        end
    end

    describe "Show Action" do
        context "Fetch an existing social club" do
            it "should fetch social club with given ID" do
                @request.headers[:token] =  token
                get :show, params: { id: social_club1.id }
                expect(response).to have_http_status(:ok)
            end
        end

        context "Fetch a non-existing social club" do
            it "should throw not found error" do
                @request.headers[:token] =  token
                get :show, params: { id: 143 }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    describe "Update Action" do
        context "update an existing social club" do
            it "should update social club with given ID" do
                @request.headers[:token] =  token
                put :update, params: { id: social_club1.id, data: { attributes: { description: "description1", age_should_be: 18} } }
                expect(response).to have_http_status(:ok)
            end
        end

        context "update a social club with invalid attributes" do
            it "should throw error" do
                @request.headers[:token] =  token
                put :update, params: { id: social_club1.id, data: { attributes: { description: "", age_should_be: ""} } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end

        context "update a non-existing social club" do
            it "should throw not found error" do
                @request.headers[:token] =  token
                put :update, params: { id: 1911, data: { attributes: { description: "description1", age_should_be: 18} } }
                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
    end

    describe "Destroy Action" do
        context "delete an existing social club" do
            it "should delete social club with given ID" do
                @request.headers[:token] =  token
                delete :destroy, params: { id: social_club1.id }
                expect(response).to have_http_status(:ok)
            end

            it "should throw an error with given ID" do
                @request.headers[:token] =  token
                delete :destroy, params: { id: social_club1.id }
                expect(response).to have_http_status(:ok)
            end
        end
    end

    describe "Club events" do
        context "Fetch events" do
            it 'should return success event' do
                @request.headers[:token] =  token
                get :club_events, params: {social_club_id: social_club1.id}
                expect(response).to have_http_status(:ok)
            end

            it 'should return empty event' do
                @request.headers[:token] =  token
                get :club_events, params: {social_club_id: social_club1.id}
                expect(JSON.parse(response.body)['data']['data']).to eq []
            end

            it 'should allow guest user' do
                @request.headers[:token] = BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')
                get :club_events, params: {social_club_id: social_club1.id}
                expect(response).to have_http_status(200)
            end

            it 'guest user allow to access api' do
                @request.headers[:token] = nil
                get :club_events, params: {social_club_id: social_club1.id}
                expect(response).to have_http_status(200)
            end
        end
    end

    describe "Joined clubs list" do
        context "Fetch list" do
            it 'should return success event' do
                @request.headers[:token] =  token
                get :existing_joined_clubs
                expect(response).to have_http_status(:ok)
            end

            it 'should return empty event' do
                @request.headers[:token] =  token
                get :existing_joined_clubs
                expect(JSON.parse(response.body)['data']).to eq []
            end

            it 'should return invalid user' do
                @request.headers[:token] =  BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'signup')
                get :existing_joined_clubs
                expect(response).to have_http_status(401)
            end
        end
    end

    describe "Places list" do
        context "Fetch places" do
            it 'should return success event' do
                @request.headers[:token] =  token
                get :place_lists, params: {social_club_id: social_club1.id}
                expect(response).to have_http_status(:ok)
            end

            it 'should return empty event' do
                @request.headers[:token] =  token
                get :place_lists, params: {social_club_id: social_club1.id}
                expect(JSON.parse(response.body)['data']['data']).to eq []
            end

            it 'should allow guest user' do
                @request.headers[:token] =  BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'signup')
                get :place_lists, params: {social_club_id: social_club1.id}
                expect(response).to have_http_status(200)
            end
        end
    end

    describe 'My Social Clubs' do
        context 'Get My clubs' do
            it 'should return success' do
                @request.headers[:token] =  token
                get :my_social_clubs
                expect(response).to have_http_status(:ok)
            end

            it 'should return club data' do
                @request.headers[:token] =  token
                get :my_social_clubs
                expect(JSON.parse(response.body)['data']).to eq []
            end

            it 'should return club data with search' do
                @request.headers[:token] =  token
                get :my_social_clubs, params: {search: 'Test'}
                expect(JSON.parse(response.body)['data']).to eq []
            end
        end
    end
end
