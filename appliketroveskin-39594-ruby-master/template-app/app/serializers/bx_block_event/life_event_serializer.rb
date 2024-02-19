module BxBlockEvent
  class LifeEventSerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :info_text, :created_at, :updated_at

    attribute "frame_images" do |object|
      object.frame_images.map{|frame_image|
      {
        id: frame_image.id,
        user_type: frame_image.user_type,
        image: get_image_url(frame_image)
      }}
    end
  end
end