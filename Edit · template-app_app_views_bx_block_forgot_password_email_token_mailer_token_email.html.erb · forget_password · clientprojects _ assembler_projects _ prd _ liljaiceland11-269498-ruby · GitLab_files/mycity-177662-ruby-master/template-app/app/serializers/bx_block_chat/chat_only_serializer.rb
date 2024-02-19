module BxBlockChat
  class ChatOnlySerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :name, :conversation_sid, :group_image, :last_msg, :last_msg_time, :chat_participants

    attribute :chat_participants do |object, params|
      BxBlockChat::AccountChatShowSerializer.new(object.accounts_chats).serializable_hash[:data]&.map{|data| data[:attributes]}
    end
    # has_many :accounts, serializer: ::AccountBlock::AccountSerializer
    attributes :last_msg do |object, params|
      @client = params[:client]
      @client.conversations.conversations(object.conversation_sid).messages&.list({order: 'desc'})&.first&.body rescue nil
    end

    attributes :last_msg_time do |object, params|
      @client = params[:client]
      @client.conversations.conversations(object.conversation_sid).messages&.list({order: 'desc'})&.first&.date_created rescue nil
    end
  end
end
