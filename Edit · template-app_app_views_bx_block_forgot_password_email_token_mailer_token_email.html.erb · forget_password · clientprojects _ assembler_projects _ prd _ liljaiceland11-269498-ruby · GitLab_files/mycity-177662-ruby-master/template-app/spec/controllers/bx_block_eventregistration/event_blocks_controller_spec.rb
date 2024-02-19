require 'rails_helper'

RSpec.describe BxBlockEventregistration::EventBlocksController, type: :controller do
    let(:user) { AccountBlock::Account.create!(full_name: "dsfdfdsf", password: "12345678", user_name: "dfdfdsfs") }
    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:images) { [ file1, file2 ] }
    let(:invalid_params) do 
        { event_name: "volunteer", 
                         location: "12.2.2.31.88",
                         start_date_and_time: "17/11/2022", 
                         end_date_and_time: "18/11/2022",
                         description: "Building Block creation",
                         start_time: "10:00:45",
                         end_time: "13:00:55" }
        end

    let(:valid_params) { invalid_params.merge({ images: images })}
                         
    let(:event) { BxBlockEventregistration::EventBlock.create!(valid_params)}

    before :each do
        @request.headers[:token] =  BuilderJsonWebToken.encode user.id, 10.minutes.from_now
    end

    context "Index Action" do
        it "should returns all the events" do
            get :index
            expect(response).to have_http_status(:ok)
        end
    end

    describe "Create Action" do
        context "Create new event with invalid attributes" do
            it "should return validation errors" do
                post :create, { params: { data: { attributes: invalid_params } } }
                expect(response).to have_http_status(:unprocessable_entity)
            end        
        end

        context "Create new event with valid attributes" do
            it "should create a new event with given attributes" do
                post :create, { params: { data: { attributes: valid_params } } }
                expect(response).to have_http_status(:created)
                expect(BxBlockEventregistration::EventBlock.count).to eq 1
            end        
        end
    end

    describe "Show Action" do
        context "Fetch an existing evnt" do
            it "should fetch an event with given ID" do
                get :show, params: { id: event.id }
                expect(response).to have_http_status(:ok)
            end
        end

        context "Fetch a non-existing event" do
            it "should throw not found error" do
                get :show, params: { id: 143 }
                expect(response).to have_http_status(:not_found)
            end
        end
    end
end