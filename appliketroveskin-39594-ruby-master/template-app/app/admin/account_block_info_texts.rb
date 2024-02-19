
ActiveAdmin.register AccountBlock::InfoText, as: "Info Text" do

    permit_params :screen, :description

    index do
      selectable_column
      column :id
      column :screen
      column :description
      actions
    end

    form do |f|
        f.inputs do
          f.input :screen
          f.input :description, as: :ckeditor
        end
        f.actions
    end
end
  
