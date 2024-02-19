module AccountBlock
  class ActiveHour < ApplicationRecord
    self.table_name = :active_hours
    belongs_to :account, class_name: 'AccountBlock::Account'
  end
end
