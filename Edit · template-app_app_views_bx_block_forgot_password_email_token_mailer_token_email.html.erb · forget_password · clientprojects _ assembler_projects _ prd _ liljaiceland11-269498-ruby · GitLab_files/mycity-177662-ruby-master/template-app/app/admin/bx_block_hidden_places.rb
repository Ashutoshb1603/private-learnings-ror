ActiveAdmin.register BxBlockHiddenPlaces::HiddenPlace, as: "Hidden Places" do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :place_name, :google_map_link, :account_id, :description, :id, :activity_ids => [], :travel_item_ids => [], weather_ids: [], images: []
  
  index do 
    selectable_column
    column :id
    column :place_name
    column :google_map_link
    column :description

    actions
  end

  form do |f|
    f.inputs do
      f.input :account
      f.input :place_name
      f.input :google_map_link
      f.input :description
      f.input :images, as: :file, input_html: {multiple: true}
    end

    f.inputs "Activities" do
      f.input :activities, as: :check_boxes
    end

    f.inputs "Travel Items" do
      f.input :travel_items, as: :check_boxes
    end

    f.inputs "Weathers" do
      f.input :weathers, as: :check_boxes
    end

    f.actions

  end
  
end
