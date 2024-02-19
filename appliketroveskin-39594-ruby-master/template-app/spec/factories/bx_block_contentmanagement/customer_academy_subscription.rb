FactoryBot.define do
  factory :customer_academy_subscription, :class => 'BxBlockContentmanagement::CustomerAcademySubscription' do

    account_id { 1 }
    academy_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    payment_id { "test123" }
  end
end
