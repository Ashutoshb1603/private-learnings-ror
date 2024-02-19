require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockNotifications::MembershipExpiringSoonNotifyWorker, type: :job do
  describe 'perform' do
    before do
      account = create(:account)
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end
end

