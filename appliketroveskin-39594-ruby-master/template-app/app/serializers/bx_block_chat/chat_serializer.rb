module BxBlockChat
    class ChatSerializer < BuilderBase::BaseSerializer
      attributes :id, :name, :status, :start_date, :end_date, :pinned, :unread_messages, :last_message_details, :sender_image, :receiver_image

      attribute :name do |object, params|
        object.account == params[:current_user] ? object.therapist.name : object.account.name
      end

      attribute :unread_messages do |object, params|
        object.messages.where('is_read = false and account_id <> ?', params[:current_user].id).count
      end

      attribute :last_message_details do |object, params|
        sender = object.messages&.last&.account == params[:current_user] ? "You" : object.messages&.last&.account&.first_name.to_s
        last_message = object.messages.count == 0 ? "Send your first message" : object.messages.last.message
        created_at = object.messages.count == 0 ?  "" : object.messages.last.created_at
        time = ""
        time = created_at.to_date == Time.now.to_date ? created_at.strftime("%H:%M") : created_at.to_date == 1.day.ago.to_date ? "Yesterday" : created_at.strftime("%D") if created_at.present?
        is_time = created_at.to_date == Time.now.to_date
        {
          sender: sender,
          time: time,
          is_time: is_time,
          message: last_message.present? ? last_message : object.messages&.last.message_objects.present? ? "Recommendations" : object.messages&.last.image.attached? ? "Image" : ""
        }
      end

      attribute :sender_image do |object, params|
        current_user = params[:current_user]
        image = get_image_url(current_user)
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') unless image.present?
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end

      attribute :receiver_image do |object, params|
        receiver = params[:current_user] == object.account ? object.therapist : object.account
        image = get_image_url(receiver)
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') unless image.present?
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end
       attribute :receiver_id do |object, params|
        receiver = params[:current_user] == object.account ? object.therapist : object.account
        receiver.id
       end
    end
  end
  
