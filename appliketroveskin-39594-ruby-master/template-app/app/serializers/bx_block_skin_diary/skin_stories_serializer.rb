module BxBlockSkinDiary
  class SkinStoriesSerializer < BuilderBase::BaseSerializer
    attributes :id, :client_name, :age, :concern, :description, :created_at, :updated_at 
    
    attribute :concern do |object|
      object.concern.title
    end

    attribute :before_image do |object|
      object&.before_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.before_image, only_path: true) : nil
    end

    attribute :after_image do |object|
      object&.after_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.after_image, only_path: true) : nil
    end
  end
end
