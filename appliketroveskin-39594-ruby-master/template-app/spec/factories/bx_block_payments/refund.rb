FactoryBot.define do
  factory :refund, :class => 'BxBlockPayments::Refund' do

    charge_id { "test123" }
    refund_id { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
