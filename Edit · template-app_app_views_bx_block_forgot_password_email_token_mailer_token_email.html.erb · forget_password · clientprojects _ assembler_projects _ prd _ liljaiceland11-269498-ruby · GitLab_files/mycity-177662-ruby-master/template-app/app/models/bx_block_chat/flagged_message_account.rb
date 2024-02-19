module BxBlockChat
  class FlaggedMessageAccount < BxBlockChat::ApplicationRecord
    self.table_name = :flagged_message_accounts
    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :flagged_message, class_name: "BxBlockChat::FlaggedMessage"

    validates :account_id, uniqueness: { scope: [:flagged_message_id], message: "has already flagged" }
  end
end
