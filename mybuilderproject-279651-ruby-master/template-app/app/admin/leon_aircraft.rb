ActiveAdmin.register_page "LeonAircraft" do
  content :title => proc{ "Leon"} do
    columns do
      column do
        span "Aircrafts", class: 'summary__title'
        div do
          br
          table_for BxBlockCatalogue::Aircraft.leon.each do |aircraft|
            column(:tail_number)
            column(:aircraft_type)
            column(:type_name)
            column(:aircraft_base_icao)
            column(:aircraft_base_iata)
            column(:aircraft_base_easa)
            column(:is_aircraft)
            column(:is_helicopter)
            column 'Category' do |aircraft|
              aircraft.category
            end
            column 'Operator' do |aircraft|
              aircraft.operator
            end
          end
        end
      end
    end
  end
end
