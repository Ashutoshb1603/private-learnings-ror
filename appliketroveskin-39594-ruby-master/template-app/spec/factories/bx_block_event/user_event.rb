FactoryBot.define do
  factory :user_event, :class => 'BxBlockEvent::UserEvent' do

    life_event_id { 1 }
    account_id { 1 }
    event_date { Time.now.to_date }
    created_at { Time.now }
    updated_at { Time.now }
    show_frame_till { Time.now }
  end
end
