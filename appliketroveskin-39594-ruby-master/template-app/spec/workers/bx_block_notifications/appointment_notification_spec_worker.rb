require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockNotifications::AppointmentNotificationWorker, type: :job do
  describe 'perform' do
    before do
      @account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
      @appointment = create(:appointment, account: @account)
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async()
      end
    end
  end
end
