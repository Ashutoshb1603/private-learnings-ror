FactoryBot.define do
  factory :crew_account, class: "BxBlockCatalogue::CrewAccount" do
  	name { Faker::Name.name }
    operator_name { Faker::Name.name }
    account_number { 214235254}
    association :crew
  end
end