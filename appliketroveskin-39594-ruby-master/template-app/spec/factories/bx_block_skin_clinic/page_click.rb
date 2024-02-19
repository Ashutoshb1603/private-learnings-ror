FactoryBot.define do
  factory :page_click, :class => 'BxBlockSkinClinic::PageClick' do

    click_count { 1 }
    accountable_type { "test123" }
    accountable_id { 1 }
    objectable_type { "test123" }
    objectable_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
