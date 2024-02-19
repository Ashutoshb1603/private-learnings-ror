require 'spec_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe GooglePlaceWorker, :type => :worker do
  let(:attributes) {{city: 'madurai', latitude: '9.9261153', longitude: "78.1140983"}}
  
  describe "#perform_later" do
    it 'ActionItemWorker jobs are enqueued in the scheduled queue' do
      described_class.perform_async(attributes)
      assert_equal 'default', described_class.queue
    end

    it 'goes into the jobs array for testing environment' do
      expect do
        described_class.perform_async(attributes)
      end.to change(described_class.jobs, :size).by(1)
      described_class.new.perform(attributes)
    end
  end
end