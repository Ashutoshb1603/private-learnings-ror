require 'rails_helper'
require 'sidekiq/testing'
RSpec.describe BxBlockContentmanagement::SendMailsWorker, type: :job do
  let(:account) { FactoryBot.create(:email_account, :with_user_role) }
  let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) }
  let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) }
  let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) }
  let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) }
  let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }


  describe 'perform' do
    before do
      @account = create(:account, created_at: 1.month.before, updated_at: 1.year.before)
      @academy = create(:academy)
      email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
    end

    it 'runs' do
      Sidekiq::Testing.inline! do
        described_class.perform_async(@academy)
      end
    end
  end
end



