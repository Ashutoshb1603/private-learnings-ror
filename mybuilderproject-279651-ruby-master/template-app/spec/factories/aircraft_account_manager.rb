FactoryBot.define do
  factory :aircraft_account_manager, class: "BxBlockCatalogue::AircraftAccountManager" do
  	first_name { Faker::Name.name }
  	last_name { Faker::Name.name }
    association :aircraft
  end
end