ActiveAdmin.register BxBlockCategories::TravelItem, as: "Travel Item"  do
  menu parent: "Categories",:priority => 2

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name,:name_ar

  form do |f|
    f.inputs except: ['account']
    f.actions
  end
  
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
