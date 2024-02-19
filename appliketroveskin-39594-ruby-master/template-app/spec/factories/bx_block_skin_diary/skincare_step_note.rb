FactoryBot.define do
  factory :skincare_step_note, :class => 'BxBlockSkinDiary::SkincareStepNote' do

    comment { "test123" }
    skincare_step_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
