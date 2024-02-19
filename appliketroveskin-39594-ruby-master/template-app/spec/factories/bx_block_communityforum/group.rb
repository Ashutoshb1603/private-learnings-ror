FactoryBot.define do
  factory :group, :class => 'BxBlockCommunityforum::Group' do

    title { "test123" }
    status { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
