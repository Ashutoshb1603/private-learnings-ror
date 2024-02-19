module BxBlockNotifications
  class NotificationSerializer < BuilderBase::BaseSerializer
    # include FastJsonapi::ObjectSerializer
    attributes *[
        :id,
        :created_by,
        :headings,
        :contents,
        :app_url,
        :is_read,
        :read_at,
        :created_at,
        :updated_at,
        :accountable,
        :notification_type,
        :room_name,
        :user_type,
        :redirect,
        :sid,
        :type,
        :record_id,
        :notification_for,
        :profile_pic
    ]

    attribute :accountable do |object|
      account = object.accountable
      {
        id: account&.id,
        first_name: account&.first_name,
        name: account&.name,
        email: account&.email,
        role: account&.role&.name
      }
    end

    attribute :type do |object|
      object.type_by_user
    end
    
    attribute :post_id do |object|
      if object.notification_for == 'comment'
       post_id = BxBlockCommunityforum::Comment.where(id: object.record_id).pluck(:objectable_id).map(&:to_s).first
       post_id
      end
    end

    attribute :profile_pic do |object, params|
      if object.type_by_user == 'admin'
        # account = AccountBlock::Account.find(object.created_by)
        # image = get_image_url(account) ? get_image_url(account) : ""
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('admin')
      elsif object.type_by_user == 'skin_hub'
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('skin_hub')
      else
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('brand_image')
      end
      is_glow_getter = params[:current_user].membership_plan[:plan_type] != "free"
      image = get_image_url(dynamic_image, is_glow_getter) unless dynamic_image.nil?
      image
    end
  end
end
