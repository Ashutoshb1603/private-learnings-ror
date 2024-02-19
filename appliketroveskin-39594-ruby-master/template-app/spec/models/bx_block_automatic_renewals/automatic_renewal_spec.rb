require 'rails_helper'

RSpec.describe BxBlockAutomaticRenewals::AutomaticRenewal, type: :model do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to validate_presence_of(:account_id) }
  it { is_expected.to validate_presence_of(:subscription_type) }
end
