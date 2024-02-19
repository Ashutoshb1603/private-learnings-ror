# FactoryBot.define do 
#   factory :availability, class: BxBlockAppointmentManagement::Availability do
#     service_provider_id { AccountBlock::Account.first.id }
#     start_time { "01:00" }
#     end_time { "04:59" }
#     unavailable_start_time { "02:00" }
#     unavailable_end_time { "02:59" }
#     availability_date { Date.today.to_s }
#   end
# end
