namespace :payment do
  desc "Daily payment"

  task daily_payment: :environment do
    subscriptions = BxBlockPayments::Subscription.where(frequency: 'daily', is_cancelled: false)
    BxBlockPayments::Payment.add_money_in_wallet(subscriptions, 1)
  end

  desc "Weekly payment"

  task weekly_payment: :environment do
    subscriptions = BxBlockPayments::Subscription.where(frequency: 'weekly', is_cancelled: false)
    BxBlockPayments::Payment.add_money_in_wallet(subscriptions, 7)
  end

  desc "Monthly payment"

  task monthly_payment: :environment do
    subscriptions = BxBlockPayments::Subscription.where(frequency: 'monthly', is_cancelled: false)
    BxBlockPayments::Payment.add_money_in_wallet(subscriptions, 30)
  end

end
