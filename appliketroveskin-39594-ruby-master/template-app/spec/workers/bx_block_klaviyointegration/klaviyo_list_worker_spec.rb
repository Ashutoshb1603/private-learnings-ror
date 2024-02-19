require 'rails_helper'
require 'sidekiq/testing' 
RSpec.describe BxBlockKlaviyointegration::KlaviyoListWorker, type: :job do
  describe 'perform' do
    before do
      account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
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