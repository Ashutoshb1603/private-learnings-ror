FactoryBot.define do
  factory :van_member, :class => 'BxBlockLocation::VanMember' do

    account_id { 1 }
    van_id { 1 }
  end
end
