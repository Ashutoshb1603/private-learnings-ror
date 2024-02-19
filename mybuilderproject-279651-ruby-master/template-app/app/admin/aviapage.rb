ActiveAdmin.register BxBlockCfaviaapi2::Aviapage, as: 'Aviapage' do
    actions :index, :show
  
    index do
        selectable_column
        # id_column
  
        # column :fluel
        column "Fuel Airway (in kg)",:fuel_airway
        column "Fuel Airway Block (in kg)",:fuel_airway_block
        # column :time
        column :time_airway
        # column :route
        column :ifr_route
        # column :airport
        column :arrival_airport
        column :departure_airport
        column :aircraft
        # column :distance
        column "distance Airway (in km) ",:distance_airway
  
        column :created_at
        column :updated_at
        actions
    end
  
    show do
        attributes_table do
        #   row :fuel
          row :fuel_airway
          row :fuel_airway_block
        #   row :time
          row :time_airway
        #   row :route
          row :ifr_route
        #   row :airport
          row :arrival_airport
          row :departure_airport
          row :aircraft
        #   row :distance
          row :distance_airway
  
        end
    end
end