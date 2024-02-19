FactoryBot.define do
  factory :admin_user, :class => 'AdminUser' do

    sequence(:email) { |n| "admin#{n}@example.com" }
    password {'test123'}
    password_confirmation {'test123'}
    encrypted_password { "test123" }
    reset_password_token { "test123" }
    reset_password_sent_at { Time.now }
    remember_created_at { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
    sequence(:first_name) { |n| "name#{n}" }
    jwt_token { "test123" }
    freeze_account { false }
    device_token { "test123" }
    device { "test123" }
    sign_in_count { 1 }
    sequence(:last_name) { |n| "name#{n}" }
    gender { "male" }
    location { "test123" }
    acuity_calendar { "test123" }
    blocked { false }

    trait :with_admin_role do
      role { BxBlockRolesPermissions::Role.find_or_create_by(name: "Admin") }
    end
  end
end
