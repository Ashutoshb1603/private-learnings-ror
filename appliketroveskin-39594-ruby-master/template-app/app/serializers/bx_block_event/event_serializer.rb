module BxBlockEvent
  class EventSerializer < BuilderBase::BaseSerializer
    attributes :id, :event_date, :account, :created_at, :updated_at, :show_frame_till

    attribute :event_date do |object|
      object.event_date.to_date.strftime("%d/%m/%Y")
    end

    attribute :life_event do |object, params|
      life_event = object.life_event
      frame_image = object.account.membership_plan.present? ? life_event&.frame_images&.glow_getter&.first :
                  life_event&.frame_images&.bronze&.first
      {
        id: life_event&.id,
        name: life_event&.name,
        frame_image: {
          id: frame_image&.id,
          user_type: frame_image&.user_type,
          image: get_image_url(frame_image)
        }
      }
    end

    attribute :show_frame do |object|
      show_frame = false
      show_frame = Time.now < object.show_frame_till ? true : false unless object.show_frame_till.nil?
      show_frame
    end

  end
end