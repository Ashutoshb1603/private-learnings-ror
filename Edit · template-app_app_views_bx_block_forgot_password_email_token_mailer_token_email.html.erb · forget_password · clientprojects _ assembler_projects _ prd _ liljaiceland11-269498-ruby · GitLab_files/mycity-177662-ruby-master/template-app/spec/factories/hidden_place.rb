FactoryBot.define do
  factory :hidden_place, class: 'BxBlockHiddenPlaces::HiddenPlace' do
      account_id { FactoryBot.create(:Account).id}
      place_name {"Test"}
      description {"Test place "}
      google_map_link {"https://goo.gl/maps/5sgrXxtv8EmmdMTH9"}
      latitude {13.0474878}
      longitude {80.0689254}
  end
end