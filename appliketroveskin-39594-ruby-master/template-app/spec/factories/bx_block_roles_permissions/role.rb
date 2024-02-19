FactoryBot.define do
  factory :role, :class => 'BxBlockRolesPermissions::Role' do

    sequence(:id) { |n| n }
    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }

    trait "with admin" do
      name { "Admin" }
    end

    trait "with_therapist" do
      name { "Therapist" }
    end
    trait "with_user" do
      name { "User" }
    end

  end
end
