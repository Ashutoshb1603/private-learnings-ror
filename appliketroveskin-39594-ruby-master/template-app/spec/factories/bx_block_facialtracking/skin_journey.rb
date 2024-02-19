FactoryBot.define do
  factory :skin_journey, :class => 'BxBlockFacialtracking::SkinJourney' do

    before_image_url { "test123" }
    after_image_url { "test123" }
    message { "test123" }
    account_id { 1 }
    therapist_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    therapist_type { "test123" }
    trait "with_therapist" do
      association :therapist, factory: [:account, :with_therapist_role]
    end

    trait "with_admin" do
      association :therapist, factory: :admin_user
    end
  end
end
