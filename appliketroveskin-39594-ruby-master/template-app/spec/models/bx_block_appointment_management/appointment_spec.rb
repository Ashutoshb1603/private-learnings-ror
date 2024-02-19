require 'rails_helper'

RSpec.describe BxBlockAppointmentManagement::Appointment, :type => :model do
	it { is_expected.to belong_to(:account) }
end