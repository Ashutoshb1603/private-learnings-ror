FactoryBot.define do
  factory :dynamic_image, :class => 'AccountBlock::DynamicImage' do
    image_type { 2 }
    created_at { Time.now }
    updated_at { Time.now }
    # image { fixture_file_upload(Rails.root.join("spec", "support", "assets", "3.png"), 'image/jpeg') }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/1.jpeg'), 'image/jpeg') }
    trait :email_cover_type do
      image_type { "email_cover" }
    end
    trait :email_logo_type do
      image_type { "email_logo" }
    end
    trait :email_tnc_type do
      image_type { "email_tnc_icon" }
    end
    trait :policy_icon_type do
      image_type { "policy_icon" }
    end
    trait :email_profile_icon_type do
      image_type { "email_profile_icon"  }
    end
    trait :profile_type do
      image_type { "profile" }
    end
    trait :visit_button_type do
      image_type { "visit_button" }
    end
    trait :skin_hub_type do
      image_type { "skin_hub" }
    end
    trait :brand_image_type do
      image_type { "brand_image" }
    end
    trait :profile_pic_type do
      image_type { "profile_pic" }
    end
    trait :admin_type do
      image_type { "admin" }
    end
  end
end