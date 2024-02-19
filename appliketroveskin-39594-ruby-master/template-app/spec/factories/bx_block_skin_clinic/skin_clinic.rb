FactoryBot.define do
  factory :skin_clinic, :class => 'BxBlockSkinClinic::SkinClinic' do

    sequence(:name) { |n| "name#{n}" }
    location { "Vauxhall Street, Balbriggan Urban ED, Balbriggan, Fingal, County Dublin, Leinster, K32 TW27, Ireland" }
    longitude { -0.61834004e1 }
    latitude {  0.536084418e2 }
    created_at { Time.now }
    updated_at { Time.now }
    country { "Ireland" }
    clinic_link { "https://phorest.com/book/salons/monicatolansbeautyclinic" }
  end
end
