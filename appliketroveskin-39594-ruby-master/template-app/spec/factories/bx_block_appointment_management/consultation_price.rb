FactoryBot.define do
  factory :consultation_price, :class => 'BxBlockAppointmentManagement::ConsultationPrice' do

    currency { 1 }
    price { 1 }
    consultation_id { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
