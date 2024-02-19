FactoryBot.define do
  factory :wallet, :class => 'BxBlockPayments::Wallet' do

    account_id { 1 }
    balance { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    currency { 1 }
  end
end
