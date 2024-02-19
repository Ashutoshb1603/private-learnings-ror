FactoryBot.define do
  factory :aircraft_equipment, class: "BxBlockCatalogue::AircraftEquipment" do
  	v110 { true }
  	v230 { true }
    association :aircraft
  end
end