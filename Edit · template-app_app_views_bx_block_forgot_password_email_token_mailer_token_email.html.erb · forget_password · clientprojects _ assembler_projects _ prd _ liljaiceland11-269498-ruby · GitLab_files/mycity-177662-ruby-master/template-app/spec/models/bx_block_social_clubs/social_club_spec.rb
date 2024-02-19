require 'rails_helper'

RSpec.describe BxBlockSocialClubs::SocialClub, :type => :model do
    let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
    let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
    let(:user) { AccountBlock::Account.create!(full_name: "manoj", email: "k.manojkumar369@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs") }
    let(:interest1) {BxBlockInterests::Interest.create(name: "tree", icon: file1)}
    let(:interest2) {BxBlockInterests::Interest.create(name: "gate", icon: file2)}
    let(:images) { [ file1, file2 ] }
    subject { described_class.new(
        account_id: user.id,
        name: "Cultural",
        location: "12.2.2.31.88",
        description: "Description",
        images: images,
        interest_ids: [interest1.id, interest2.id],
        status: "draft",
        is_visible: false,
        community_rules: "1.safety 2.damage control",
        user_capacity: 25,
        bank_name: "HD Bank",
        bank_account_name: "Social Club account",
        bank_account_number: "13245690897765434",
        routing_code: "xxxxx",
        fee_amount_cents: 33.55)
    }

    it "is not valid without user" do
        subject.account_id = user.id
        expect(subject).to be_valid
    end
    
    it "is not valid without a name" do
        subject.name = nil
        expect(subject).to be_invalid
    end

    it "is not valid without images" do
        subject.images = nil
        expect(subject).to be_invalid
    end

    it "is valid with images" do
        subject.images = images
        expect(subject.valid?).to eq true
    end

    it "is not valid without a description" do
        subject.description = nil
        expect(subject).to be_invalid
    end

    it "is not valid without a interests" do
        subject.interest_ids = nil
        expect(subject).to be_invalid
    end

    it "is not valid without a community rules" do
        subject.community_rules = nil
        expect(subject).to be_invalid
    end

    it "is not valid without a location" do
        subject.location = nil
        expect(subject).to be_invalid
    end

    it "is not valid without a Bank name" do
        subject.is_visible = false  
        subject.bank_name = nil
        expect(subject).to be_invalid
    end

    it "is not valid without a Bank account name" do
        subject.bank_account_name = nil
        expect(subject).to be_invalid
    end

    it "is not valid without a Bank account number" do
        subject.bank_account_number = nil
        expect(subject).to be_invalid
    end

    it "is not valid without a routing code" do
        subject.routing_code = nil
        expect(subject).to be_invalid
    end

    it "is not valid without amount" do
        subject.fee_amount_cents = nil
        expect(subject).to be_invalid
    end

    it "is not valid without user capacity" do
        subject.user_capacity = nil
        expect(subject).to be_invalid
    end

    it 'city and coordinated should be update' do
        subject.location = 'https://goo.gl/maps/ZpNzCB7St9SoM84Z9'
        subject.save
        expect(subject.city).to eq('Madurai')
        expect(subject.latitude).not_to be_nil
        expect(subject.longitude).not_to be_nil
    end
end
