require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockNotifications::LiveNotifyWorker, type: :job do
  describe 'perform' do
    before do
      @account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
      @live_schedule = create(:live_schedule, at: 0.5.hour.after, user_type: "all")
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end

  describe 'perform' do
    before do
      @account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
      @live_schedule = create(:live_schedule, at: 0.5.hour.after, user_type: "elite_and_glow_getters")
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end

  describe 'perform' do
    before do
      @account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
      @live_schedule = create(:live_schedule, at: 0.5.hour.after, user_type: "elite_and_glow_getters")
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end

  describe 'perform' do
    before do
      @account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
      @live_schedule = create(:live_schedule, at: 0.5.hour.after, user_type: "free")
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end


  describe 'perform' do
    before do
      @account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
      @live_schedule = create(:live_schedule, at: 0.5.hour.after)
      @membership_plan = create(:membership_plan, account: @account)
    end
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end

end

