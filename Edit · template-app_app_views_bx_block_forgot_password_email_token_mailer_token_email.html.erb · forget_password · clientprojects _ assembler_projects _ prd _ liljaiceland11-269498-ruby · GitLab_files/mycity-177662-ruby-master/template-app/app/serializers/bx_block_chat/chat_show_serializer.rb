module BxBlockChat
    class ChatShowSerializer < BuilderBase::BaseSerializer
      include FastJsonapi::ObjectSerializer
  
      attributes :id, :name, :conversation_sid, :social_club_id, :group_image, :chat_type, :accounts, :created_at, :updated_at

      attributes :accounts do |object, params|
        BxBlockChat::AccountChatShowSerializer.new(object.accounts_chats).serializable_hash[:data]&.map{|data| data[:attributes]}
      end
    end
  end
  