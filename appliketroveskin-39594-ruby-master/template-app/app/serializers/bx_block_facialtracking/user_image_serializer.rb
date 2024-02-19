module BxBlockFacialtracking
  class UserImageSerializer < BuilderBase::BaseSerializer
    attributes :id, :position, :account_id, :created_at, :updated_at

    attribute :image do |object|
      get_image_url(object)
    end
  end
end