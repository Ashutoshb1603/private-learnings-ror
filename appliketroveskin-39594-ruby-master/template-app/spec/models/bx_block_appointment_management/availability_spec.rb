require 'rails_helper'

RSpec.describe BxBlockAppointmentManagement::Availability, :type => :model do
	BxBlockAppointmentManagement::Availability.delete_all
	BxBlockAppointmentManagement::BookedSlot.delete_all
    let(:available) { FactoryBot.create(:availability) }
    let(:booked_slot) { FactoryBot.create(:booked_slot) }
    let(:result) { [{:from=>"01:00 AM", :to=>"01:59 AM", :booked_status=>true, :sno=>"1"}, {:from=>"02:00 AM", :to=>"02:59 AM", :booked_status=>false, :sno=>"2"}, {:from=>"03:00 AM", :to=>"03:59 AM", :booked_status=>false, :sno=>"3"}, {:from=>"04:00 AM", :to=>"04:59 AM", :booked_status=>false, :sno=>"4"}] }
	it { is_expected.to belong_to(:service_provider) }
	it { is_expected.to validate_presence_of(:availability_date) }
	it { is_expected.to validate_presence_of(:start_time) }
	it { is_expected.to validate_presence_of(:end_time) }
	# it "Should return all the available slots" do
	# 	puts "#{booked_slot.inspect}"
	# 	expect(available.slots_list).to eql(result)
	# end
	# it "Should update slot count" do
	# 	expect(available.update_slot_count).to be_truthy
	# end
end