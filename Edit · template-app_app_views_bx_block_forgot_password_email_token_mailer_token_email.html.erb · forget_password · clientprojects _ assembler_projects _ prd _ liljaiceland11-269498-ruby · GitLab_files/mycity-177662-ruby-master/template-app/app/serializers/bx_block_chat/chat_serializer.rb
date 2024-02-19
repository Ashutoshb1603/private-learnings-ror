module BxBlockChat
  class ChatSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :name, :conversation_sid, :group_image

    has_many :accounts, serializer: ::AccountBlock::AccountSerializer

    attribute :messages do |object, params|
      serializer = BxBlockChat::ChatMessageSerializer.new(
        object.messages, { params: params }
      )
      serializer.serializable_hash[:data]
    end
  end
end
