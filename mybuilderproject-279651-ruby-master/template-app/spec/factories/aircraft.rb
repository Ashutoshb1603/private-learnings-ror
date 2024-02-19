FactoryBot.define do
  factory :aircraft, class: "BxBlockCatalogue::Aircraft" do
  	tail_number { Faker::Name.name + Random.hex(3)}
    aircraft_type { Faker::Name.name }
  end
end