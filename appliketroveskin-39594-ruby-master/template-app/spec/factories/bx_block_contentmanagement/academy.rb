FactoryBot.define do
  factory :academy, :class => 'BxBlockContentmanagement::Academy' do

    title { "test123" }
    description { "test123" }
    price { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    price_in_pounds { 1 }
  end
end
