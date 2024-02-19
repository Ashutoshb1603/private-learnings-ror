module BxBlockSocialClubs
  class AroundPlaceEventsSerializer < BuilderBase::BaseSerializer

    attributes :event_name, :id, :location

    attribute :images do |object, params|
      if object.images.attached?
        object.images.map{|a| a.service_url}
      end
    end

    attribute :start_date do |object|
      object.start_date_and_time.strftime("%d/%m/%Y") if object.start_date_and_time.present?
    end

    attribute :start_time do |object|
      object.start_date_and_time.strftime("%H:%M:%S") if object.start_date_and_time.present?
    end

  end
end
