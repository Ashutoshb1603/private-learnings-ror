require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockNotifications::ScheduledNotificationWorker, type: :job do
  describe 'perform' do
    before do
     create(:account)
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end
end

