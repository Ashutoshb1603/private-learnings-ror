FactoryBot.define do
  factory :info_text, :class => 'AccountBlock::InfoText' do

    description { "test123" }
    screen { "life_event" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
