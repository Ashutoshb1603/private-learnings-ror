ActiveAdmin.register BxBlockCatalogue::Aircraft, as: 'Flex Aircraft Types' do
  actions :index, :show

  index do
    id_column
    column :aircraft_type
    column "Action" do |resource|
      link_to("View Live Flights (RadarBox)",admin_flights_path(aircraft_type: resource.aircraft_type) )
    end
  end

  filter :aircraft_type

  controller do
    def scoped_collection
      ids = BxBlockCatalogue::Aircraft.where.not(aircraft_type: nil).uniq(&:aircraft_type).pluck(:id)
      BxBlockCatalogue::Aircraft.where(id: ids)
    end
  end
end