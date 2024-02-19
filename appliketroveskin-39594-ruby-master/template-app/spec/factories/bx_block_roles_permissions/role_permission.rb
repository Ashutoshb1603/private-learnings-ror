FactoryBot.define do
  factory :role_permission, :class => 'BxBlockRolesPermissions::RolePermission' do

    role_id { 1 }
    permission_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
