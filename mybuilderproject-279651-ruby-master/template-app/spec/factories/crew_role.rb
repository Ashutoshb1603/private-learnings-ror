FactoryBot.define do
  factory :crew_role, class: "BxBlockCatalogue::CrewRole" do
  	role_type { Faker::Name.name }
    label { Faker::Name.name }
    association :crew
  end
end