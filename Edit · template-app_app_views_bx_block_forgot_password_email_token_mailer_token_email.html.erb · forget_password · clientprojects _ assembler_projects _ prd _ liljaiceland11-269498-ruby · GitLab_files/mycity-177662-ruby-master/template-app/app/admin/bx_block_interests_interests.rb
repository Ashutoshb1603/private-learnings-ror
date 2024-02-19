ActiveAdmin.register BxBlockInterests::Interest, as: "Interests" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name,:name_ar,:icon
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys
      f.input :name
      f.input :name_ar
      f.input :icon,as: :file

    end

    f.actions
  end
  show do
    attributes_table do
      row :name
      row :name_ar
      row :icon do |ad|
        link_to(ad.icon.filename , url_for(ad.icon), target: :_blank) if ad.icon.present?
      end      
    end
  end
end
