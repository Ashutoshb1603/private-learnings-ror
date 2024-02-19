module BxBlockChat
    class FlaggedMessageSerializer < BuilderBase::BaseSerializer
      include FastJsonapi::ObjectSerializer
  
      attributes :id, :conversation_sid, :message_sid, :flag_count, :accounts

      attributes :flag_count do |object, params|
        object.flagged_message_accounts&.count
      end

      attributes :accounts do |object, params|
        object.flagged_message_accounts&.map{ |flag_account|
          {
            id: flag_account.account&.id,
            email: flag_account.account&.email
          }
        }
      end
    end
  end
  