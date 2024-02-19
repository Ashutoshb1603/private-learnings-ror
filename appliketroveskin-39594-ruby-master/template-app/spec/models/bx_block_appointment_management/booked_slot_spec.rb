require 'rails_helper'

RSpec.describe BxBlockAppointmentManagement::BookedSlot, :type => :model do
	it { is_expected.to belong_to(:service_provider) }
end