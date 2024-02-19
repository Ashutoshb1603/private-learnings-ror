ActiveAdmin.register BxBlockPayments::GiftType, as: 'GiftType' do

    permit_params :name, :status, :free_user_image, :gg_user_image
    menu label: "Glow Gifts"
  
    index do
      selectable_column
      column :name
      column :status
      column "Free user image" do |gift_type|
        gift_type.free_user_image.attached? ? image_tag(gift_type.free_user_image, :size=>200) : ''
      end
      column "GG user image" do |gift_type|
        gift_type.gg_user_image.attached? ? image_tag(gift_type.gg_user_image, :size=>200) : ''
      end
      actions
    end

    form do |f|
        inputs 'Gift Type' do
          f.semantic_errors
          f.inputs :name
          f.input :status
          f.input :free_user_image, as: :file
          f.input :gg_user_image, as: :file
        end
        actions
      end
    
      show do |gift_type|
        attributes_table do
          row :name
          row :status
          row "Free user image" do |gift_type|
            gift_type.free_user_image.attached? ? image_tag(gift_type.free_user_image) : ''
          end
          row "GG user image" do |gift_type|
            gift_type.gg_user_image.attached? ? image_tag(gift_type.gg_user_image) : ''
          end
        end
      end

end
  