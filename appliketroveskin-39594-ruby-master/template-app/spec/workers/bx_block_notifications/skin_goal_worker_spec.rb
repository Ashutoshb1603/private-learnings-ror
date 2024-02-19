
require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockNotifications::SkinGoalWorker, type: :job do
  describe 'perform' do
    before do
      @account = create(:account)
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async(@account.id)
      end
    end
  end
end

