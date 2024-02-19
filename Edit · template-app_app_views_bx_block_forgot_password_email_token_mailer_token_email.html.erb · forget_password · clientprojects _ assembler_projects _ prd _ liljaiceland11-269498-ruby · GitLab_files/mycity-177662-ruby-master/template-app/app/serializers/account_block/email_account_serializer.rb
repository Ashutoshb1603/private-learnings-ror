module AccountBlock
  class EmailAccountSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :full_name,
      :user_name,
      :full_phone_number,
      :country_code,
      :phone_number,
      :email,
      :activated,
    ]
  end
end
