FactoryBot.define do
  factory :home_page_view, :class => 'BxBlockContentmanagement::HomePageView' do

    accountable_type { "test123" }
    accountable_id { 1 }
    view_count { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
