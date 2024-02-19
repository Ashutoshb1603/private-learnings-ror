# ActiveAdmin.register BxBlockConsultation::ConsultationType, as: 'ConsultationType' do

#   permit_params :name, :price, :description


#   remove_filter :created_at, :updated_at

#   breadcrumb do
#     links = [link_to('Admin', admin_root_path)]
#     if %(new create).include?(params['action'])
#       links << link_to('Consultation Types', admin_consultation_types_path)
#     end
#     links
#   end

#   csv do
#     column :name
#     column :price
#     column "Description" do |consultation_type|
#       raw(consultation_type.description)
#     end
#   end

#   index do
#     selectable_column
#     column :name
#     column :price
#     column "Description" do |consultation_type|
#       raw(consultation_type.description)
#     end
#     actions
#   end

#   form partial: 'form'

#   show do
#     attributes_table do
#       row :name
#       row :price
#       row "Description" do |consultation_type|
#         raw(consultation_type.description)
#       end
#       row :created_at
#       row :updated_at
#     end
#   end
# end
