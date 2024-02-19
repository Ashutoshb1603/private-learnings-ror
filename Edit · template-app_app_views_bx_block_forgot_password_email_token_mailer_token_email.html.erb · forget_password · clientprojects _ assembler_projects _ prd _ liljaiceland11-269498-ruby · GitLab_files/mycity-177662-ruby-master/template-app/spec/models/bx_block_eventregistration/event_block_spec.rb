require 'rails_helper'

RSpec.describe BxBlockEventregistration::EventBlock, :type => :model do
  subject { described_class.new(
    event_name: "Cultural",
    location: "12.2.2.31.88",
    start_date_and_time: "17/11/2022",
    end_date_and_time: "18/11/2022",
    description: "Building Block creation",
    start_time: "10:00:45",
    end_time: "13:00:55"
    ) }
  it "is invalid with empty attributes" do 
    expect(subject).to be_invalid
  end
  
  it "is not valid without a event_name" do
    subject.event_name = nil
    expect(subject).to be_invalid
  end

  it "is not valid without images" do
    expect(subject).to be_invalid
  end
  
    it 'is valid if images are attached' do
        file1 = Rails.root.join('spec', 'support', 'assets', 'tree.jpg')
        file2 = Rails.root.join('spec', 'support', 'assets', 'gateway.jpeg')

    image1 = ActiveStorage::Blob.create_after_upload!(
    io: File.open(file1, 'rb'),
        filename: 'tree.jpg',
        content_type: 'image/jpg' # Or figure it out from `name` if you have non-JPEGs
    ).signed_id

    image2 = ActiveStorage::Blob.create_after_upload!(
        io: File.open(file2, 'rb'),
            filename: 'gateway.jpeg',
            content_type: 'image/jpeg' # Or figure it out from `name` if you have non-JPEGs
        ).signed_id
        subject.images = [image1, image2]
        expect(subject.valid?).to eq true
        subject.save
        expect(subject.id).should_not be_nil
        expect(subject.images.attached?)
    end
   

  # it { is_expected.to validate_attachment_of(:images) }

  it "is not valid without a start_date_and_time" do
    subject.start_date_and_time = nil
    expect(subject).to be_invalid
  end

  it "is not valid without a end_date_and_time" do
    subject.end_date_and_time = nil
    expect(subject).to be_invalid
  end

  it "is not valid without a start_time" do
    subject.start_time = nil
    expect(subject).to be_invalid
  end

  it "is not valid without a end_time" do
    subject.end_time = nil
    expect(subject).to be_invalid
  end

  it "is not valid without a location" do
    subject.location = nil
    expect(subject).to be_invalid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to be_invalid
  end

end
