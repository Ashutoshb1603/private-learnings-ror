FactoryBot.define do
  factory :availability, class: BxBlockAppointmentManagement::Availability do

    service_provider_id { AccountBlock::Account.first.id }
    start_time { "01:00" }
    end_time { "04:59" }
    unavailable_start_time { "05:00" }
    unavailable_end_time { "07:59" }
    availability_date { Date.today.strftime('%d/%m/%y') }
    created_at { Time.now }
    updated_at { Time.now }
    timeslots { "test123" }
    available_slots_count { 1 }
  end
end

