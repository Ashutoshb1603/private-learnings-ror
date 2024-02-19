module BxBlockChat
    class MessageSerializer < BuilderBase::BaseSerializer
      attributes :id, :name, :status, :start_date, :end_date, :pinned, :messages

      attribute :name do |object, params|
        object.account == params[:current_user] ? object.therapist.name : object.account.name
      end

      attribute :messages do |object, params|
        object.messages.order('created_at').map {|message| 
            {
                name: params[:current_user] == message.account ? "You" : message.account.name,
                message: message.message,
                is_read: message.is_read,
                time: message.created_at.ctime,
                message_objects: MessageObjectSerializer.new(message.message_objects),
                image: message.image.attached? ? get_image_url(message) : nil
            }
        }
      end



    end
  end
  