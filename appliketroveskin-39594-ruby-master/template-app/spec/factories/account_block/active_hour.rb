FactoryBot.define do
  factory :active_hour, :class => 'AccountBlock::ActiveHour' do
    association :account, factory: :account
    from { Time.now }
    to { Time.now }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
