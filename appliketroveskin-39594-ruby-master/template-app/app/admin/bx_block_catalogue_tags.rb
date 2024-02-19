# ActiveAdmin.register BxBlockCatalogue::Tag, as: 'Tag' do

#   # See permitted parameters documentation:
#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   permit_params :name

#   remove_filter :catalogue, :choice_tags, :choices, :created_at, :updated_at

#   breadcrumb do
#     links = [link_to('Admin', admin_root_path)]
#     if %(new create).include?(params['action'])
#       links << link_to('Tags', admin_tags_path)
#     end
#     links
#   end
#   #
#   # or
#   #
#   # permit_params do
#   #   permitted = [:name]
#   #   permitted << :other if params[:action] == 'create' && current_user.admin?
#   #   permitted
#   # end
  
#   csv do
#     column :name
#   end

#   index do
#     selectable_column
#     column :name
#     actions
#   end
# end
