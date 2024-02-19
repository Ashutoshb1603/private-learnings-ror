FactoryBot.define do
  factory :location, :class => 'BxBlockLocation::Location' do

    latitude { "test123" }
    longitude { "test123" }
    van_id { 1 }
  end
end
