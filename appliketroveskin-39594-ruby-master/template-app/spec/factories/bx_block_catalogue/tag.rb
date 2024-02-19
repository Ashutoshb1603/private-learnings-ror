FactoryBot.define do
  factory :tag, :class => 'BxBlockCatalogue::Tag' do

    title { "test123" }
    status { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
