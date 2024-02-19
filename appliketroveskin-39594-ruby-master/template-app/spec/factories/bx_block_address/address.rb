FactoryBot.define do
  factory :address, :class => 'BxBlockAddress::Address' do

    country { "UK" }
    latitude { "test123" }
    longitude { "test123" }
    address_type { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    addressable_type { "AccountBlock::Account" }
    addressable_id { 1 }
    street { "test123" }
    county { "test123" }
    postcode { "test123" }
    address { "test123" }
    city { "test123" }
    province { "test123" }
    shopify_address_id { "test123" }
  end
end
