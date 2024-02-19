require "rails_helper"

RSpec.describe BxBlockSocialClubs::CreateChatJob, :type => :job do
  let(:user) { AccountBlock::Account.create!(full_name: "aaa", email: "aaa@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }

  describe "#perform_later" do
    it "Creates a group chat" do
      social_club = FactoryBot.create(:social_club)
      ActiveJob::Base.queue_adapter = :test
      expect {
        BxBlockSocialClubs::CreateChatJob.perform_later(social_club, user)
      }.to have_enqueued_job
    end
  end
end