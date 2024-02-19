require 'rails_helper'

RSpec.describe BxBlockEventregistration::AccountEventBlocksController, type: :controller do
    let(:user) { AccountBlock::Account.create!(full_name: "dsfdfdsf", password: "12345678", user_name: "dfdfdsfs") }
    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:images) { [ file1, file2 ] }
    let(:event_block_params) do
        {   event_name: "volunteer", 
            location: "12.2.2.31.88",
            start_date_and_time: "17/11/2022", 
            end_date_and_time: "18/11/2022",
            description: "Building Block creation",
            start_time: "10:00:45",
            end_time: "13:00:55",
            images: images
        }
    end
                         
    let(:event) { BxBlockEventregistration::EventBlock.create!(event_block_params)}

    before :each do
        @request.headers[:token] =  BuilderJsonWebToken.encode user.id, 10.minutes.from_now
    end

    describe "Create Event Registration" do
        context "Create event registration with valid attributes" do
            it "should create a new event registration with given attributes" do
                post :create, params: { event_id: event.id, account_id: user.id}
                expect(response).to have_http_status(:created)
                expect(BxBlockEventregistration::AccountEventBlock.count).to eq 1
            end
        end
    end
end
