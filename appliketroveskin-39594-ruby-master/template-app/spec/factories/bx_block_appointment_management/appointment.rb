FactoryBot.define do
  factory :appointment, :class => 'BxBlockAppointmentManagement::Appointment' do

    appointment_id { "test123" }
    sequence(:firstname) { |n| "name#{n}" }
    sequence(:lastname) { |n| "name#{n}" }
    phone { "+44000000000" }
    sequence(:email) { |n| "test#{n}@example.com" }
    date { Time.now }
    time { "test123" }
    endtime { "test123" }
    price { 1 }
    appointment_type { "test123" }
    calendar { "test123" }
    calendar_id { "test123" }
    canceled { true }
    account_id { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    transaction_id { "test123" }
  end
end
