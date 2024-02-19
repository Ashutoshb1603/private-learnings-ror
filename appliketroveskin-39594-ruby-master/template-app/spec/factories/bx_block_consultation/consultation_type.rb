FactoryBot.define do
  factory :consultation_type, :class => 'BxBlockConsultation::ConsultationType' do

    sequence(:name) { |n| "name#{n}" }
    price { 1 }
    description { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
