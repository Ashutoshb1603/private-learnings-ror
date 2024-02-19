ActiveAdmin.register BxBlockCatalogue::Aircraft, as: 'Flex Aircraft' do
  actions :index, :show
  config.per_page = 10

  index do
    selectable_column
    id_column
    column :tail_number
    column :aircraft_type
    column :model
    column :type_name
    column :category
    column :homebase
    column :wing_span
    column :max_fuel
    column :external_length
    column :external_height
    column :cabin_height
    column :cabin_length
    column :cabin_width
    column :flight_number_token
    column :subcharter
    column :cargo
    column :ambulance
    column :type_rating
    column :type_of_use
    column :number_of_seats
    column :cabin_crew
    column :flight_crew
    column :onboard_engineer
    column :created_at
    column :updated_at
    actions
  end

  controller do
    def scoped_collection
      BxBlockCatalogue::Aircraft.where(is_file_imported: false)
    end
  end

  show do
    attributes_table do
      row :tail_number
      row :aircraft_type
      row :model
      row :type_name
      row :homebase
      row :wing_span
      row :max_fuel
      row :external_length
      row :external_height
      row :cabin_height
      row :cabin_length
      row :cabin_width
      row :category_id
      row :flight_number_token
      row :subcharter
      row :cargo
      row :ambulance
      row :type_rating
      row :type_of_use
      row :number_of_seats
      row :cabin_crew
      row :flight_crew
      row :onboard_engineer
      panel 'Aircraft Equipment' do
        if resource.aircraft_equipment.present?
          table_for resource.aircraft_equipment do
            column :v110
            column :v230
            column :headsets
            column :tv
            column :cd_dvd
            column :wifi
            column :sat_phone
            column :sat_tv
            column :entertainment_system
            column :lavatory
            column :enclosed_lavatory
            column :coffee_pot
            column :espresso
            column :ice_bin
            column :microwave_oven
            column :warming_oven
            column :smoking_allowed
            column :pets_allowed
            column :baggage_volume
            column :ski_tube
            column :golf_bags
            column :standard_suitcases
            column :max_weight
          end
        else
          "Not Available"
        end
      end

      panel "Aircraft Schedule" do
        if resource.aircraft_schedules.present?
          table_for resource.aircraft_schedules do
            column :schedule_id
            column :departure_airport
            column :arrival_airport
            column :arrival_date
            column :arrival_date_utc
            column :departure_date
            column :departure_date_utc
            column :pax
            column :trip_number
            column :workflow
            column :fpl_type
            column :workflow_custom_name
          end
        end
      end

      panel 'Aircraft Pictures' do
        if resource.aircraft_links.where(rel: "picture").present?
          table_for resource.aircraft_links.where(rel: "picture") do
            column "image" do |image|
              if image.picture.attached?
                img src: Rails.application.routes.url_helpers.rails_blob_url(image.picture, only_path: true), height: 150, width: 150
              end
              # img src: image.link_url, height: 250, width: 250
            end
          end
        else
          "Not Available"
        end
      end

      panel 'Account Manager Details' do
        if resource.aircraft_account_manager.present?
          table_for resource.aircraft_account_manager do
            column :external_reference
            column :first_name
            column :last_name
            column :log_name
            column :gender
            column :status
            column :salutation
            column :internal_id
          end
        else
          "Not Available"
        end
      end
    end
  end



end