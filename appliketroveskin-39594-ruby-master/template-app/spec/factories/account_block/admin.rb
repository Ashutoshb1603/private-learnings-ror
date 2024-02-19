FactoryBot.define do
  factory :admin, :class => 'AdminUser' do
   
    sequence(:first_name) { |n| "name#{n}" }
    sequence(:email) { |n| "admin#{n}@example.com" }
    password {'admin123'}
    password_confirmation {'admin123'}
    created_at { Time.now }
    updated_at { Time.now }
    jwt_token { "test123" }
    freeze_account { true }
    device_token { "test123" }
    sign_in_count { 1 }
    sequence(:last_name) { |n| "name#{n}" }
    gender { "male" }
    location { "test123" }
    acuity_calendar { "test123" }
    blocked { true }

     trait :primary_image_type do
      image_type { "primary_image" }
    end

    trait :secondary_image_type do
      image_type { "secondary_image" }
    end

    
  end
end
