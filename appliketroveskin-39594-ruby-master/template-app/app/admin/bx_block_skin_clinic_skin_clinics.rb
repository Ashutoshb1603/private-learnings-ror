ActiveAdmin.register BxBlockSkinClinic::SkinClinic, as: 'Skin Clinic' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  menu label: "Treatment Clinic(s) Locations"
  permit_params :name, :location, :longitude, :latitude, :clinic_link, skin_clinic_availabilities_attributes: [:id, :day, :from, :to, :skin_clinic_id, :_destroy]
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :location, :longitude, :latitude]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  remove_filter :skin_clinic_availabilities, :created_at, :updated_at

  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Skin Clinics', admin_skin_clinics_path)
  #   end
  #   links
  # end

  index do
    selectable_column
    column :name
    column :location
    column :country
    column :latitude
    column :longitude
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs do
      f.input :name
      f.input :location
      f.input :clinic_link
      f.has_many :skin_clinic_availabilities do |availability|
        availability.semantic_errors
        availability.input :day
        availability.input :from, as: :time_picker
        availability.input :to, as: :time_picker
        availability.input :_destroy, as: :boolean
      end
    end
    actions
  end

  show do |skin_clinic|
    attributes_table do
      row :name
      row :location
      row :country
      row :latitude
      row :longitude
      row :created_at
      row :updated_at
      if skin_clinic.skin_clinic_availabilities.present?
        div class: 'panel' do
          h3 'Availability'
          div class: 'attributes_table' do
            table do
              tr class: 'table-header' do
                th 'Availability id'
                th 'Day'
                th 'From'
                th 'To'
              end
              skin_clinic.skin_clinic_availabilities.each do |availability|
                tr do
                  td availability.id
                  td availability.day
                  td availability.from.strftime("%I:%M %p")
                  td availability.to.strftime("%I:%M %p")
                end
              end
            end
          end
        end
      end
    end
  end

  csv do
    column :name
    column :location
    column :country
    column :latitude
    column :longitude
    column :availabilities do |skin_clinic|
      skin_clinic.skin_clinic_availabilities.map{|availability| availability.day + " #{availability.from.strftime("%I:%M%p")} To #{availability.to.strftime("%I:%M%p")}"}.join(", ")
    end
  end
end
