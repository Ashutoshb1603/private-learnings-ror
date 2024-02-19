module AccountBlock
    class AdminAccountSerializer < BuilderBase::BaseSerializer
      attributes *[
        :first_name,
        :last_name,
        :name,
        :email,
        :freeze_account,
        :gender,
        :acuity_calendar,
        :blocked,
        :created_at
      ]

      attribute :profile_pic do |object|
        image = get_image_url(object) || ""
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') if image == ""
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end

      attribute :profile_pic_added do |object|
        image = get_image_url(object).present?
      end

      attribute :membership_plan do |object|
        {plan_type: "glow_getter"}
      end
  
      attribute :unread_notifications do |object, params|
        notifications = object&.notifications&.unread
        notifications.count || 0
      end

      attribute :addresses do |object|
        object.addresses.where(shopify_address_id: nil).order('created_at')
      end
      
    end
end
  