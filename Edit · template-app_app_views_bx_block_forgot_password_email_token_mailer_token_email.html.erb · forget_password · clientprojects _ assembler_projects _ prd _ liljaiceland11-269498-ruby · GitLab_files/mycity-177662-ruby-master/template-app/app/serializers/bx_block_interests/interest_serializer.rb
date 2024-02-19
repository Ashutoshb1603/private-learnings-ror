module BxBlockInterests
  class InterestSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    
    attribute :icon do |object|
      object.icon.attached? ? object.icon.service_url : nil
    end

    attribute :name do |object, params|
      if params[:current_user].blank?
        if params[:language].present?
          params[:language] == 'english' ? object.name : object.name_ar
        else
          object.name
        end
        
      else
        params[:current_user]&.english? ? object.name : object.name_ar
      end
    end

  end
end
