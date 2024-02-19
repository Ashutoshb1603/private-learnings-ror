module BxBlockEventregistration
  class AccountEventBlock < ApplicationRecord
    self.table_name = :account_event_blocks

    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :event_block, class_name: "BxBlockEventregistration::EventBlock"
  end
end
