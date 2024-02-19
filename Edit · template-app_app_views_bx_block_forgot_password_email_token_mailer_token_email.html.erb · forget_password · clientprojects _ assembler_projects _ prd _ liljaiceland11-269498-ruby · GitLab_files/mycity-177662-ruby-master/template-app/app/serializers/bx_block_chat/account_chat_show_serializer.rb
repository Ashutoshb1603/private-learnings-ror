module BxBlockChat
    class AccountChatShowSerializer < BuilderBase::BaseSerializer
      include FastJsonapi::ObjectSerializer
  
      attributes :id, :account_id, :full_name, :account_image, :first_name, :last_name, :chat_id, :status, :is_admin, :participant_sid

      attributes :account_image do |object, params|
        object.account&.image&.service_url rescue nil
      end

      attributes :full_name do |object, params|
        object.account&.full_name
      end

      attributes :first_name do |object, params|
        object.account&.first_name
      end

      attributes :last_name do |object, params|
        object.account&.last_name
      end
    end
  end
  