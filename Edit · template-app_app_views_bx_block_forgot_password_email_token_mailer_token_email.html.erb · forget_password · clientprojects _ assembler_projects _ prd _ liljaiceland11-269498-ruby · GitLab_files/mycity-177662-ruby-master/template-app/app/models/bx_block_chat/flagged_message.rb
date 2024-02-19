module BxBlockChat
  class FlaggedMessage < BxBlockChat::ApplicationRecord
    self.table_name = :flagged_messages
    has_many :flagged_message_accounts, class_name: "BxBlockChat::FlaggedMessageAccount"
    has_many :accounts, through: :flagged_message_accounts, class_name: "AccountBlock::Account"
  end
end
