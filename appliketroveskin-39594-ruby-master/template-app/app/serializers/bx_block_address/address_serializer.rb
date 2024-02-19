module BxBlockAddress
  class AddressSerializer < BuilderBase::BaseSerializer

    attributes *[
      :latitude,
      :longitude,
      :street,
      :county,
      :postcode,
      :address,
      :address_type,
      :city,
      :province
    ]
  end
end
