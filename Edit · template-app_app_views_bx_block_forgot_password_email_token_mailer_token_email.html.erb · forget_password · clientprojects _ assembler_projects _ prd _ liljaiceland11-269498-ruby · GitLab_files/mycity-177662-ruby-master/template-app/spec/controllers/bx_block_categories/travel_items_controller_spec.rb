require 'rails_helper'

RSpec.describe BxBlockCategories::TravelItemsController, type: :controller do
    let(:user) { FactoryBot.create(:Account)}
    let(:travel_item) { BxBlockCategories::TravelItem.create!(travel_item_params) }
    let(:travel_item_params) do 
        {
            name: "Tent"
        }
    end

    before :each do
        @request.headers[:token] =  BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')
    end

    describe "Create action" do
        context "create Travel Item with valid params" do
            it "should create a new travel item" do
                post :create, { params: {data: travel_item_params} }
                expect(response).to have_http_status(:created)
                expect(BxBlockCategories::TravelItem.count).to eq 1
            end
        end
    end

    describe "Index action" do
        context "Gives list of Travel Items" do
            it "should return travel items" do
                travel_item
                get :index
                expect(response).to have_http_status(:ok)
                expect(BxBlockCategories::TravelItem.count).to eq 1
            end
        end
    end

    describe "Delete action" do
        context "Deletes an Travel Item" do
            it "Deletes an travel item" do
                delete :destroy, params: { id: travel_item.id }
                expect(response).to have_http_status(:ok)
            end
        end
    end
end