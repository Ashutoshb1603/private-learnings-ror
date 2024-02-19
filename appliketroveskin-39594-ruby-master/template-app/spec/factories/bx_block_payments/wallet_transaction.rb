FactoryBot.define do
  factory :wallet_transaction, :class => 'BxBlockPayments::WalletTransaction' do

    wallet_id { 1 }
    transaction_type { 1 }
    amount { 1 }
    status { 1 }
    comment { "test123" }
    created_at { Time.now }
    updated_at { Time.now }
    sender_id { 1 }
    receiver_id { 1 }
    reference_id { "test123" }
    custom_message { "test123" }
    gift_type_id { 1 }
    currency { 1 }
  end
end
