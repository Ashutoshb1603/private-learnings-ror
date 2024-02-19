module BxBlockAdmins
  class TermsAndConditionSerializer < BuilderBase::BaseSerializer
    attributes :id, :description, :description_ar

    attribute :description do |object, params|
      if params[:current_user].blank?
        if params[:language].present?
          params[:language] == 'english' ? object.description : object.description_ar
        else
          object.description
        end
      else
        params[:current_user]&.english? ? object.description : object.description_ar
      end
    end
  end
end
