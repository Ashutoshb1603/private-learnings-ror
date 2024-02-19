require 'rails_helper'
require 'sidekiq/testing' 
RSpec.describe BxBlockCatalogue::ShopifyProductsWorker, type: :job do
  describe 'perform' do
    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async
      end
    end
  end
end