module BxBlockChat
    class MessageObject < ApplicationRecord
        self.table_name = :message_objects
        belongs_to :message, class_name: 'BxBlockChat::Message'

        
    end
end
