FactoryBot.define do
  factory :consultation_addon_price, :class => 'BxBlockAppointmentManagement::ConsultationAddonPrice' do

    addon_price { 16 }
    weeks { 2 }
    created_at { Time.now }
    updated_at { Time.now }
    addon_price_in_pounds { 1 }
  end
end
