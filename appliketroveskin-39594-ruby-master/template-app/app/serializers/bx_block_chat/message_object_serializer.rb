module BxBlockChat
    class MessageObjectSerializer < BuilderBase::BaseSerializer
      attributes :id, :object_id, :object_type, :title, :price, :variant_id, :image_url
    end
  end
  