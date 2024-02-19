module BxBlockHiddenPlaces
  class HiddenPlaceSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes *[
      :place_name,
      :google_map_link,
      :description,
      :latitude,
      :longitude
    ]

    attributes :images do |object|
      object.images.map{|a| a.service_url} rescue nil
    end

    attributes :account_details do |object| 
      AccountBlock::EmailAccountSerializer.new(object.account).serializable_hash
    end

    attributes :activities do |object|
      object.activities.as_json
    end
    
    attributes :weathers do |object|
      object.weathers.as_json
    end

    attributes :travel_items do |object|
      object.travel_items.as_json
    end
    
  end
end
