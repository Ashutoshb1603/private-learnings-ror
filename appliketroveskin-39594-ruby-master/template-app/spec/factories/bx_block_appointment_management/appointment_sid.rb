FactoryBot.define do
  factory :appointment_sid, :class => 'BxBlockAppointmentManagement::AppointmentSid' do

    appointment_id { "test123" }
    sid { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
