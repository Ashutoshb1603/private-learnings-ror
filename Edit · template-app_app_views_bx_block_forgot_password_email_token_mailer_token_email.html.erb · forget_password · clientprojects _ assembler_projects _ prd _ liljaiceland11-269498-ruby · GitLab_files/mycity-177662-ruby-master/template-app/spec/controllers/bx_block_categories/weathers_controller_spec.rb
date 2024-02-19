require 'rails_helper'

RSpec.describe BxBlockCategories::WeathersController, type: :controller do
    let(:user) { FactoryBot.create(:Account)}
    let(:weather) { BxBlockCategories::Weather.create!(weather_params) }
    let(:weather_params) do 
        {
            name: "Winter"
        }
    end

    before :each do
        @request.headers[:token] =  BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')
    end

    describe "Create action" do
        context "create weather with valid params" do
            it "should create a new weather" do
                post :create, { params: {data: weather_params} }
                expect(response).to have_http_status(:created)
                expect(BxBlockCategories::Weather.count).to eq 1
            end
        end
    end

    describe "Index action" do
        context "Gives list of Weather" do
            it "should return Weather" do
                weather
                get :index
                expect(response).to have_http_status(:ok)
                expect(BxBlockCategories::Weather.count).to eq 1
            end
        end
    end

    describe "Delete action" do
        context "Deletes an Weather" do
            it "Deletes an Weather" do
                delete :destroy, params: { id: weather.id }
                expect(response).to have_http_status(:ok)
            end
        end
    end
end