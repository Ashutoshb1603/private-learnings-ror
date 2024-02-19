require 'rails_helper'

RSpec.describe BxBlockSocialClubs::AccountSocialClubsController, type: :controller do
    let(:user) { AccountBlock::Account.create!(full_name: "aaa", email: "aaa@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:interest1) {BxBlockInterests::Interest.create(name: "tree", icon: file1)}
    let(:interest2) {BxBlockInterests::Interest.create(name: "gate", icon: file2)}
    let(:images) { [ file1, file2 ] }
    let(:social_club_params) do
        {   account_id: user.id,
            name: "Cultural",
            location: "12.2.2.31.88",
            description: "Description",
            interest_ids: [interest1.id, interest2.id],
            community_rules: "1.safety 2.damage control",
            images: images,
            is_visible: true,
            status: "approved"
        }
    end
                         
    let(:social_club) { BxBlockSocialClubs::SocialClub.create!(social_club_params)}
    let(:token) {BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')}
    let(:account_social_club) {BxBlockSocialClubs::AccountSocialClub.create(social_club_id: social_club.id, account_id: user.id)}

    describe "Social Club membership" do
        context "Join social club with valid attributes" do
            it "should create a new social club member with given attributes" do
                @request.headers[:token] =  token

                post :create, params: { social_club_id: social_club.id, account_id: user.id }
                expect(response).to have_http_status(:created)
                expect(BxBlockSocialClubs::AccountSocialClub.count).to eq 1
            end
        end

        context "Join social club is not approved. so," do
            it "should not create a new social club member with given attributes" do
                ["draft", "archieved", "deleted"].each do |st|
                    social_club.update!(status: st)          
                    @request.headers[:token] =  token
                    post :create, params: { social_club_id: social_club.id, account_id: user.id }
                    expect(response).to have_http_status(:unprocessable_entity)
                end
            end
        end
    end

    describe "Index" do
        context "This should return all the participants of a social club" do
            it "should returns all social club participants" do
                account_social_club
                @request.headers[:token] =  token
                get :index, params: { social_club_id: social_club.id }
                expect(response).to have_http_status(:ok)
                expect(JSON.parse(response.body).size).to eq(1)       
            end
        end
    end
end
