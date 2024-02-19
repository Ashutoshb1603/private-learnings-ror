ActiveAdmin.register BxBlockEvent::LifeEvent, as: 'LifeEvent' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :info_text, frame_images_attributes: [:id, :user_type, :life_event_id, :image, :_destroy]

  remove_filter :created_at, :updated_at, :frame_images, :user_events, :accounts

  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Life Events', admin_life_events_path)
  #   end
  #   links
  # end

  csv do
    column :name
    column(:frame_images){ |life_event| life_event.frame_images.map{|frame_image| Rails.application.routes.url_helpers.url_for(frame_image.image) if frame_image.image.attached?}}
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    selectable_column
    column :name
    column "Frame Image" do |life_event|
      life_event.frame_images.map{|frame_image| frame_image.image.attached? ? image_tag(frame_image.image) : ''}
    end
    actions
  end

  form do |f|
    inputs 'LifeEvent' do
      f.semantic_errors *f.object.errors.keys
      f.inputs :name
      f.input :info_text, as: :ckeditor
      f.has_many :frame_images, heading: "Frame Images" do |frame_image|
        frame_image.semantic_errors
        frame_image.input :user_type, as: :select, collection: BxBlockEvent::FrameImage.user_types
        frame_image.input :image, as: :file, wrapper_html: { class: 'life_event_image' }
        frame_image.input :_destroy, as: :boolean
      end
    end
    actions
  end

  show do |life_event|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
      if life_event.frame_images.present?
        div class: 'panel' do
          h3 'Frame Images'
          div class: 'attributes_table' do
            table do
              tr class: 'table-header' do
                th 'Frame Image id'
                th 'User Type'
                th 'Image'
              end
              life_event.frame_images.each do |frame_image|
                tr do
                  td frame_image.id
                  td frame_image.user_type
                  td frame_image.image.attached? ? image_tag(frame_image.image) : ''
                end
              end
            end
          end
        end
      end
    end
  end
end
