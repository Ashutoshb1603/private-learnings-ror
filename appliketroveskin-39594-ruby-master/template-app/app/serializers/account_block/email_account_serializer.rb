module AccountBlock
  class EmailAccountSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :name,
      :first_name,
      :last_name,
      :full_phone_number,
      :gender,
      :country_code,
      :phone_number,
      :email,
      :activated,
      :device_token,
      :device,
      :addresses,
      :membership_plan,
      :acuity_calendar,
      :stripe_customer_id,
      :is_subscribed_to_mailing,
      :freeze_account,
      :age,
      :location,
      :created_at,
      :blocked
    ]

    attribute :addresses do |object|
      object.addresses.order('created_at')
    end

    attribute :profile_pic do |object|
      image = get_image_url(object) ? get_image_url(object) : ""
      dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') if image == ""
      image = get_image_url(dynamic_image) unless dynamic_image.nil?
      image
    end

    attribute :profile_pic_added do |object|
      image = get_image_url(object).present?
    end

    attribute :membership_plan do |object|
      object.membership_plan.present? ? object.membership_plan : {plan_type: "free"}
    end

    attribute :unread_notifications do |object, params|
      notifications = object&.notifications&.unread
      notifications.count || 0
    end

    attribute :cart_items_count do |object, params|
      cart_items_count = object&.cart_items&.count
      cart_items_count || 0
    end

    attribute :unread_messages do |object, params|
      count = object.therapist? ? object&.customer_chats&.last&.messages&.where(is_read: false)&.count : object&.chats&.last&.messages&.where(is_read: false)&.count
      count || 0
    end

    attribute :user_event do |object|
      user_event = object.user_event
      life_event = object.user_event&.life_event
      show_frame = false
      show_frame = Time.now < user_event.show_frame_till ? true : false unless life_event.nil? or user_event.show_frame_till.nil?
      show_frame
      life_event.present? ?
      {
        id: user_event.id,
        event_date: user_event.event_date.to_date.strftime("%d/%m/%Y"),
        show_frame_till: user_event.show_frame_till,
        show_frame: show_frame,
        life_event: {
          id: life_event.id,
          name: life_event.name,
          frame_image: get_image_url(object.membership_plan.present? ? life_event.frame_images&.glow_getter&.first : life_event.frame_images&.bronze&.first)
        }
      }
      :
      {
      }
    end

  end
end
