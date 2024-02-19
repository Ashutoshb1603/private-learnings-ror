ActiveAdmin.register BxBlockRolesPermissions::Role, as: 'Roles' do

  menu :parent => "Staff Roles & Permissions", :priority => 1

  permit_params :name, permission_ids: []
  index do
    selectable_column
    column :name

    actions
  end

  filter :name

  form do |f|
    inputs 'Role'do
      f.input :name
      f.input :permission_ids, label: "Permissions", as: :select, collection: BxBlockRolesPermissions::Permission.all.map {|p| ["Can #{p.can} #{p.name.split('::').second}", p.id]}, multiple: true
    end
    actions
  end


end
