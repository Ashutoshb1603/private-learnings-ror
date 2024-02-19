ActiveAdmin.register BxBlockContactUs::Contact, as: 'Contact Detail' do
  menu parent: 'Content Management System', label: 'Contact Detail'
  actions :index, :show

  index do
    id_column
    column :first_name
    column :last_name
    column :email
    column :phone_number
    column :company_name
    column :description
    actions
  end
  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :phone_number
      row :company_name
      row :description
    end
  end
end