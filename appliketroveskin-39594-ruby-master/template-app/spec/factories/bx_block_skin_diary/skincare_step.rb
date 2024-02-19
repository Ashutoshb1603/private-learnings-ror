FactoryBot.define do
  factory :skincare_step, :class => 'BxBlockSkinDiary::SkincareStep' do

    step { "test123" }
    skincare_routine_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    header { "test123" }
  end
end
