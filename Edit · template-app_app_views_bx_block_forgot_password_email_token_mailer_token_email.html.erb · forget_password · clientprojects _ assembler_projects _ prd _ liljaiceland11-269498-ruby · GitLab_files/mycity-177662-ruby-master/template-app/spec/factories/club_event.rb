FactoryBot.define do
  factory :club_event, class: 'BxBlockClubEvents::ClubEvent' do
    social_club_id { FactoryBot.create(:social_club).id }
    event_name {"volunteer"}
    location {"12.3278"}
    is_visible {true}
    fee_currency {"USD"}
    fee_amount_cents {100}
    max_participants {15}
    images { [fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'tree.jpg'))] }
    start_date_and_time {"17/11/2022"}
    end_date_and_time {"18/11/2022"}
    description {"Building Block creation"}
    start_time {"10:00:45"}
    end_time {"13:00:55"}
  end
end