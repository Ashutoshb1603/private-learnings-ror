ActiveAdmin.register BxBlockPlan::Plan, as: 'Plans' do

    permit_params :name, :price, :duration, :period
    menu label: "Pricing Plan Structure"
  
    index do
      selectable_column
      column :name
      column :price
      column :duration
      column :period
      actions
    end

    form do |f|
        inputs 'Plan' do
          f.inputs :name
          f.input :price
          f.input :duration
          f.input :period
        end
        actions
    end

end
  