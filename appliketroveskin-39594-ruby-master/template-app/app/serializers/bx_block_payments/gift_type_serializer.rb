module BxBlockPayments
    class GiftTypeSerializer < BuilderBase::BaseSerializer
        
      attributes *[
          :id,
          :name,
          :status
      ]

      attribute :image do |object, params|
        current_user = params[:current_user]
        image = (object&.free_user_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.free_user_image, only_path: true) : "") if current_user.membership_plan[:plan_type] == "free"
        image = (object&.gg_user_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.gg_user_image, only_path: true) : "") if current_user.membership_plan[:plan_type] != "free"
        image
      end

    end
  end
  