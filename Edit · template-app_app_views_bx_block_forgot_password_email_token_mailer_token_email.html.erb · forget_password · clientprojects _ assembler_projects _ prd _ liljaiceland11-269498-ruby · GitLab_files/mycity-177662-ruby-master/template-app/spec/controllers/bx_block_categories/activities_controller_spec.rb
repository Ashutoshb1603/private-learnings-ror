require 'rails_helper'

RSpec.describe BxBlockCategories::ActivitiesController, type: :controller do
    let(:user) { FactoryBot.create(:Account)}
    let(:activity) { BxBlockCategories::Activity.create!(activity_params) }
    let(:activity_params) do 
        {
            name: "musical",
            status: "approved"
        }
    end

    before :each do
        @request.headers[:token] =  BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')
    end

    describe "Create action" do
        context "create activity with valid params" do
            it "should create a new activity" do
                post :create, { params: {data: activity_params} }
                expect(response).to have_http_status(:created)
                expect(BxBlockCategories::Activity.count).to eq 1
            end
        end
    end

    describe "Index action" do
        context "Gives list of Activities" do
            it "should return approved activities" do
                activity
                get :index
                expect(response).to have_http_status(:ok)
                expect(BxBlockCategories::Activity.count).to eq 1
            end
        end
    end

    describe "Delete action" do
        context "Deletes an Activity" do
            it "Deletes an Activity" do
                delete :destroy, params: { id: activity.id }
                expect(response).to have_http_status(:ok)
            end
        end
    end
end