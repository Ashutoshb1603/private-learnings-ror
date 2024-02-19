require 'rails_helper'

RSpec.describe BxBlockClubEvents::ClubEvent, :type => :model do
  let(:file1) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg')) }
  let(:file2) {fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg'))}
  let(:user) { AccountBlock::Account.create!(full_name: "manoj", email: "k.manojkumar369@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs") }
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

  subject { described_class.new(
            social_club_id: social_club.id,
            event_name: "volunteer", 
            location: "12.2.2.31.88",
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
            status: "draft")
  }

  it "is valid with social club" do
    subject.social_club_id = social_club.id
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.event_name = nil
    expect(subject).to be_invalid
  end

  # it "is not valid without activities" do
  #   subject.activity_ids = nil
  #   expect(subject).to be_invalid
  # end

  # it "is not valid without equipments" do
  #   subject.equipment_ids = nil
  #   expect(subject).to be_invalid
  # end

  it "is not valid without amount" do
    subject.is_visible = false
    subject.fee_amount_cents = nil
    expect(subject).to be_invalid
  end

  it "is not valid without max_participants" do
    subject.max_participants = nil
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

  it "is not valid without a start_date_and_time" do
    subject.start_date_and_time = nil
    expect(subject).to be_invalid
  end

  it "is not valid without a start_time" do
    subject.start_time = nil
    expect(subject).to be_invalid
  end  

  it "is not valid without a end_date_and_time" do
    subject.end_date_and_time = nil
    expect(subject).to be_invalid
  end

  it "is not valid without end_time" do
    subject.end_time = nil
    expect(subject).to be_invalid
  end

  it "is not valid without a location" do
      subject.location = nil
      expect(subject).to be_invalid
  end

  it 'city and coordinated value should be update' do
    subject.location = 'https://goo.gl/maps/F5hibxHfvTqUDaC49'
    subject.save
    expect(subject.city).to eq('Coimbatore')
    expect(subject.latitude).not_to be_nil
    expect(subject.longitude).not_to be_nil
  end

  it 'state and coordinated value should be update' do
    subject.location = 'https://goo.gl/maps/zgcz3zFjN8HDvWdv6'
    subject.save
    expect(subject.city).to eq('Delhi')
    expect(subject.latitude).not_to be_nil
    expect(subject.longitude).not_to be_nil
  end

end
