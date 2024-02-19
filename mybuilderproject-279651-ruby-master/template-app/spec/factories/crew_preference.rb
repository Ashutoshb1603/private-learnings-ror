FactoryBot.define do
  factory :crew_preference, class: "BxBlockCatalogue::CrewPreference" do
  	description { Faker::Name.name }
    template_name { Faker::Name.name }
    association :crew
  end
end