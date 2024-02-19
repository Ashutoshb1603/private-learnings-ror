FactoryBot.define do
  factory :skin_treatment_location, :class => 'BxBlockSkinClinic::SkinTreatmentLocation' do

    location { "test123" }
    url { "https://www.goggle.com" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
