FactoryBot.define do
  factory :crew, class: "BxBlockCatalogue::Crew" do
  	first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    middle_name { Faker::Name.name }
  end
end