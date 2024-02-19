require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockPayments::WeeklyPaymentWorker, type: :job do
  describe 'perform' do
    before do
      account = create(:account)
      @subscription = create(:subscription, account: account)
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      stripe_customer = Stripe::Customer.create({email: account.email})
      account.update(stripe_customer_id: stripe_customer.id)
      account2 = create(:account, is_subscribed_to_mailing: false, created_at: 1.month.before)
      klaviyo_list = create(:klaviyo_list, account: account, membership_list: 'glow_getter', not_active_since_6_months: nil)
      academy = create(:academy)
      academy_subscription = create(:customer_academy_subscription, account: account, academy: academy)
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end
end
