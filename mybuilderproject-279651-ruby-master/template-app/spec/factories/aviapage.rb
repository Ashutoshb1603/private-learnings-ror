# spec/factories/bx_block_cfaviaapi2_aviapages.rb
FactoryBot.define do
  factory :aviapage, class: 'BxBlockCfaviaapi2::Aviapage' do
    fuel_airway { 'ABCD' }
    fuel_airway_block { 'WXYZ' }
    time_airway { '12:00' }
    ifr_route { 'VOR VOR VOR' }
    arrival_airport { 'LAX' }
    departure_airport { 'JFK' }
    aircraft { 'Boeing 747' }
    distance_airway { 5000 }
  end
end
