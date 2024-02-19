module BxBlockChat
  class Message < ApplicationRecord
    belongs_to :objectable, optional: true
    belongs_to :account, polymorphic: true
    belongs_to :chat, class_name: "BxBlockChat::Chat"
    has_many :message_objects, class_name: "BxBlockChat::MessageObject", dependent: :destroy
    has_one_attached :image

    accepts_nested_attributes_for :message_objects, allow_destroy: true
  end
end