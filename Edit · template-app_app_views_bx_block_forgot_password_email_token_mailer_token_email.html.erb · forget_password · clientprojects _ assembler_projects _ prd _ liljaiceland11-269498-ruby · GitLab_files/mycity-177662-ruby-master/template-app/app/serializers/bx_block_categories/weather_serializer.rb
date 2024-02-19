module BxBlockCategories
  class WeatherSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes *[:name, :name_ar]

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
