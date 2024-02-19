ActiveAdmin.register BxBlockSkinDiary::Concern, as: 'Concern' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  menu parent: 'Skin Stories', priority: 1

  permit_params :title
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :location, :longitude, :latitude]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  remove_filter :created_at, :updated_at

  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Skin Clinics', admin_skin_clinics_path)
  #   end
  #   links
  # end

  index do
    selectable_column
    column :title
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs do
      f.input :title
    end
    actions
  end

  show do |skin_clinic|
    attributes_table do
      row :title
      row :created_at
      row :updated_at
    end
  end
end
