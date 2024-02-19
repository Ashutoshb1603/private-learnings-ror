module BxBlockSkinClinic
  class SkinClinicSerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :location, :country, :latitude, :longitude, :created_at, :updated_at, :clinic_link

    attribute :availabilities do |object|
      object.skin_clinic_availabilities.order('created_at').map{|availability|
      {
        id: availability.id,
        day: availability.day,
        from: availability.from.strftime("%I:%M %p"),
        to: availability.to.strftime("%I:%M %p")
      }}
    end
  end
end