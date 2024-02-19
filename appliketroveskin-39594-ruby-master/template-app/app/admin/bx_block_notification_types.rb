ActiveAdmin.register BxBlockNotifications::NotificationType, as: "Notification Type" do


    permit_params :title, :description, :key
    actions :all

    index do
      selectable_column
      column :title
      column :description
      column :key
      actions
    end
  
  
    form do |f|
        f.inputs "Notification Type" do
            f.input :title
            f.input :description
            f.input :key
        end
        f.actions
    end

end
  