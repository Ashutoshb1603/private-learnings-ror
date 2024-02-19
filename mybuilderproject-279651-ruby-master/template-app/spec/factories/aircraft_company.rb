FactoryBot.define do
  factory :aircraft_company, class: "BxBlockCatalogue::AircraftCompany" do
  	company_name { Faker::Name.name }
    association :aircraft
  end
end