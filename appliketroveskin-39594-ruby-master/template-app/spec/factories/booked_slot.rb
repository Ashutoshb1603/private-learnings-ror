FactoryBot.define do 
  factory :booked_slot, class: BxBlockAppointmentManagement::BookedSlot do
    service_provider_id { AccountBlock::Account.first.id }
    booking_date { Date.parse(Date.today.to_s) }
    start_time { "01:00" }
    end_time { "01:59" }
  end
end