module BxBlockChat
    class AttachmentOnlySerializer < BuilderBase::BaseSerializer
        include FastJsonapi::ObjectSerializer
        attributes :attachments do |object|
            object.attachments&.map{|img| img.service_url}
        end
    end
end
  