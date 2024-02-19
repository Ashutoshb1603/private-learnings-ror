module AccountBlock
  class AccountSerializer < BuilderBase::BaseSerializer
    attributes *[
      :full_name,
      :user_name,
      :phone_number,
      :country_code,
      :email,
      :activated,
      :language,
      :service_and_policy,
      :term_and_condition,
      :age_confirmation,
      :user_type,
      :device_id,
      :unique_auth_id,
      :currency,
      :created_at,
      :updated_at,
    ]
    attributes :image do |object|
      object.image.attached? ? object.image.service_url : nil
    end
    attributes :interests do |object|
      object.interests.as_json
    end


    class << self
      private

    end
  end
end
