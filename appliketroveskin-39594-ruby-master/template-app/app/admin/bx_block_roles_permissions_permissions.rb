ActiveAdmin.register BxBlockRolesPermissions::Permission, as: 'Permission' do

  actions :all, :except => [:edit, :destroy, :new]
  menu :parent => "Staff Roles & Permissions", :priority => 2
  action_item :reload do
    link_to("Reload", "/admin/permissions/reload",  method: :post)
  end

  collection_action :reload, method: :post do
    resource_collection = ActiveAdmin.application.namespaces[:admin].resources
    resources = resource_collection.select { |resource| resource.respond_to? :resource_class }

    resources.map { |resource|
      BxBlockRolesPermissions::Permission.find_or_create_by(name: resource.resource_class.name, can: 'manage')
      BxBlockRolesPermissions::Permission.find_or_create_by(name: resource.resource_class.name, can: 'read')
    }
    respond_to do |format|
      format.html { redirect_to request.referer}
    end
  end

  index do
    selectable_column
    column :name
    column :can
    actions
  end

  filter :name
  filter :can

end
