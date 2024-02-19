ActiveAdmin.register BxBlockCategories::Activity, as: "Activity" do
  menu parent: "Categories",:priority => 0

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :name_ar, :status
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
      f.input :status, :collection => [['Draft', :draft], ['Approved', :approved], ['Archieved', :archived], ['Deleted', :deleted]]
    end
    f.actions
  end
  
end
