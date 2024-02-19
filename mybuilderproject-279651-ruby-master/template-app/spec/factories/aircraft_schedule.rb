FactoryBot.define do
  factory :aircraft_schedule, class: "BxBlockCatalogue::AircraftSchedule" do
  	departure_airport { "IDR" }
  	arrival_airport { "BLR" }
    pax { 1 }
    association :aircraft
  end
end