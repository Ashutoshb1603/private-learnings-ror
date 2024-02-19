ActiveAdmin.register BxBlockCommunityforum::Group, as: 'Groups' do

    permit_params :title, :status
    menu label: "User Tags/Groups"
    
    index do
      selectable_column
      column :title
      column :status
      actions
    end
  
    form do |f|
      inputs 'Groups' do
        f.inputs :title
        f.input :status
      end
      actions
    end
  
    show do |group|
      attributes_table do
        row :title
        row :status
      end
    end
  end
  