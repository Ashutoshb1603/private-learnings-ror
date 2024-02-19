FactoryBot.define do
  factory :permission, :class => 'BxBlockRolesPermissions::Permission' do

    sequence(:name) { |n| "name#{n}" }
    can { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
