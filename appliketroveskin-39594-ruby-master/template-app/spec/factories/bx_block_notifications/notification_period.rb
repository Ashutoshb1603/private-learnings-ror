FactoryBot.define do
  factory :notification_period, :class => 'BxBlockNotifications::NotificationPeriod' do

    notification_type { "abandon_cart" }
    period_type { "minutes" }
    period { 1 }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
