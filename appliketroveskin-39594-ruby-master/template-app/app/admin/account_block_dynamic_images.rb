
ActiveAdmin.register AccountBlock::DynamicImage, as: "Dynamic Image" do

    menu label: "Dynamic App Icons"
    permit_params :image_type, :image, :glow_getter_image

    index do
      selectable_column
      column :id
      column :image_type
      column "Image" do |i|
        image_tag i.image, size: 50 if i.image.attached?
      end
      column "Glow Getter Image" do |i|
        image_tag i.glow_getter_image, size: 50 if i.glow_getter_image.attached?
      end
      actions
    end

    form do |f|
        f.inputs do
          f.input :image_type
          f.input :image, as: :file
          f.input :glow_getter_image, as: :file
        end
        f.actions
    end
end
  
