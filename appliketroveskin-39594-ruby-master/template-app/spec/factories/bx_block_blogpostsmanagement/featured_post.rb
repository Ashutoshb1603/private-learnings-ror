FactoryBot.define do
  factory :featured_post, :class => 'BxBlockBlogpostsmanagement::FeaturedPost' do

    post_id { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
