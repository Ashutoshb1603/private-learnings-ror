FactoryBot.define do
  factory :brand, :class => 'BxBlockCatalogue::Brand' do

    sequence(:name) { |n| "name#{n}" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
