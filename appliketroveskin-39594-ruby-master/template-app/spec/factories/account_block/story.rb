FactoryBot.define do
  factory :story, :class => 'AccountBlock::Story' do

    objectable_type { "AccountBlock::Account" }
    objectable_id { 1 }
    target { 1 }
    created_at { Time.now }
    updated_at { Time.now }
    trait "with_therapist" do
      association :objectable, factory: [:account, :with_therapist_role]
    end

    trait "with_admin" do
      association :objectable, factory: :admin_user
    end
  end
end
