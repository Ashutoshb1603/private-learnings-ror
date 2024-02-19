
ActiveAdmin.register BxBlockContentmanagement::Academy, as: "Academy" do

    permit_params :title, :description, :price, :price_in_pounds, :image, academy_videos_attributes: [:id, :title, :description, :url], key_points_attributes: [:id, :description]
    
    menu :parent => "Skin Hub", label: "Academy"

    actions :all
    index do
      selectable_column 
      column :title
      column :description
      column :price
      column :price_in_pounds
      actions
    end
  
    form do |f|
      f.inputs 'Academy' do 
       f.input :title
       f.input :description
       f.has_many :key_points, heading: 'Key Points' do |point|
          point.input :description, label: "Point"
        end
       f.input :price
       f.input :price_in_pounds
       f.input :image, as: :file, label: "Cover Image"
        f.has_many :academy_videos, heading: 'Academy Videos' do |video|
            video.input :title
            video.input :description
            video.input :url
        end
      end
      actions
    end

    show do |object|
      attributes_table do
        row :id
        row :title
        row :description
        div class: 'panel' do
          h3 'Key Points'
          div class: 'attributes_table' do
              table do
                  tr class: 'table-header' do
                      th 'Id'
                      th 'Description'
                  end
                  object.key_points.each do |point|
                      tr do
                          td point.id
                          td point.description
                      end
                  end
              end
          end
        end
        row :price
        row :price_in_pounds
        row "Cover Image" do
          object.image.attached? ? image_tag(object.image, :size=>200) : ''
        end
        div class: 'panel' do
          h3 'Videos'
          div class: 'attributes_table' do
              table do
                  tr class: 'table-header' do
                      th 'Video Id'
                      th 'Title'
                      th 'Description'
                      th 'Video'
                  end
                  object.academy_videos.each do |video|
                      tr do
                          td video.id
                          td video.title
                          td video.description
                          td render "academy_video", locals: {url: video.url}
                      end
                  end
              end
          end
      end
    end
  end

end
  
