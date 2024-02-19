require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockNotifications::LiveVideoWorker, type: :job do
  describe 'perform' do
    before do
      @account = create(:account)
      @live_video = create(:live_video)
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async(@live_video)
      end
    end
  end
end

