ActiveAdmin.register BxBlockCatalogue::Aircraft, as: 'RadarBox Aircraft Details' do
  actions :index, :show

  index do
    id_column
    column :tail_number
    column "Action" do |resource|
      link_to("View Aircraft details (RadarBox)",admin_radar_aircraft_by_id_path(tail_number: resource.tail_number) )
    end
    column "Action" do |resource|
      link_to("View Live Flights (RadarBox)",admin_flights_path(tail_number: resource.tail_number) )
    end
  end

  filter :tail_number
end