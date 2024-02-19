ActiveAdmin.register BxBlockSkinDiary::SkinStory, as: 'Skin Story' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  menu parent: 'Skin Stories', priority: 2
  permit_params :client_name, :age, :concern_id, :description, :before_image, :after_image
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :location, :longitude, :latitude]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  remove_filter :age, :description, :created_at, :updated_at, :before_image, :after_image

  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Skin Clinics', admin_skin_clinics_path)
  #   end
  #   links
  # end

  index do
    selectable_column
    column :client_name
    column :age
    column :concern
    column "Before Image" do |skin_stories|
      skin_stories.before_image.attached? ? image_tag(skin_stories.before_image, :size=>200) : ''
    end
    column "After Image" do |skin_stories|
      skin_stories.after_image.attached? ? image_tag(skin_stories.after_image, :size=>200) : ''
    end
    column :description
    actions
  end

  # form do |f|
  #   f.semantic_errors *f.object.errors.keys
  #   inputs do
  #     f.input :client_name
  #     f.input :age
  #     f.input :concern
  #     f.input :before_image, as: :file
  #     f.input :after_image, as: :file
  #     f.input :description, as: :ckeditor
  #   end
  #   actions
  # end

  form partial: 'form'

  show do |skin_stories|
    attributes_table do
      row :client_name
      row :age
      row :concern
      row :description
      row :created_at
      row :updated_at
      row :before_image do |skin_stories|
        skin_stories.before_image.attached? ? image_tag(skin_stories.before_image) : ''
      end
      row :after_image do |skin_stories|
        skin_stories.after_image.attached? ? image_tag(skin_stories.after_image) : ''
      end
    end
  end

end
