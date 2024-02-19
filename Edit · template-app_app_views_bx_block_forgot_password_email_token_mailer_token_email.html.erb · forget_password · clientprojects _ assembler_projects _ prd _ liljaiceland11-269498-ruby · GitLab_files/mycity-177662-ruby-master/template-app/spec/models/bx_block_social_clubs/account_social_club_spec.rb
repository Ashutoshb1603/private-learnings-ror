require 'rails_helper'

RSpec.describe BxBlockSocialClubs::AccountSocialClub, type: :model do
  
    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:user1) { AccountBlock::Account.create!(full_name: "aaa", email: "aaa@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs") }
    let(:user2) { AccountBlock::Account.create!(full_name: "bbb", email: "bbb@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs") }
    let(:interest1) {BxBlockInterests::Interest.create(name: "tree", icon: file1)}
    let(:interest2) {BxBlockInterests::Interest.create(name: "gate", icon: file2)}
    let(:images) { [ file1, file2 ] }
    let(:social_club) { BxBlockSocialClubs::SocialClub.create(
        account_id: user1.id,
        name: "Cultural",
        location: "12.2.2.31.88",
        description: "Description",
        images: images,
        interest_ids: [interest1.id, interest2.id],
        status: "approved",
        is_visible: true,
        community_rules: "1.safety 2.damage control"
        )
    }

  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.account_id = user2.id
    subject.social_club_id = social_club.id
    expect(subject).to be_valid
  end

  it "is not valid without an account" do 
    subject.social_club_id = 1
    expect(subject).to be_invalid
  end

  it "is not valid without social club" do 
    subject.account_id = 1
    expect(subject).to be_invalid
  end
end
