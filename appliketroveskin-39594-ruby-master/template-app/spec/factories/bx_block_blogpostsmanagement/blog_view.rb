FactoryBot.define do
  factory :blog_view, :class => 'BxBlockBlogpostsmanagement::BlogView' do

    blog_id { "test123" }
    account_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
