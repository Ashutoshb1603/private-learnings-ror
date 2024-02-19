module BxBlockFacialtracking
    class SkinLogSerializer < BuilderBase::BaseSerializer
      attributes :id, :position

      attribute :created_at do |object|
        object.created_at.strftime("%d %b %Y")
      end

        attribute :updated_at do |object|
        object.updated_at.strftime("%d %b %Y")
      end

      attribute :image do |object, params|
        get_image_url(object) || ""
      end
    end
end