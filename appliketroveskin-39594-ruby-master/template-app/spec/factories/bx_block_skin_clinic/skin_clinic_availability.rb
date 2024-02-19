FactoryBot.define do
  factory :skin_clinic_availability, :class => 'BxBlockSkinClinic::SkinClinicAvailability' do

    skin_clinic_id { 1 }
    day { "test123" }
    from { Time.now }
    to { 1.day.after }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
