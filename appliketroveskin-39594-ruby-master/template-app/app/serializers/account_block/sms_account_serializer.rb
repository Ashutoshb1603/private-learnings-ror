module AccountBlock
  class SmsAccountSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :name,
      :full_phone_number,
      :gender,
      :country_code,
      :phone_number,
      :email,
      :activated,
      :device_token,
      :addresses
    ]

    attribute :profile_pic do |object|
      get_image_url(object)
    end
  end
end
