module AccountBlock
    class Device < ApplicationRecord
      self.table_name = :devices
      belongs_to :account, class_name: 'AccountBlock::Account'
  
      validates :token, uniqueness: { scope: [:account_id] }, allow_nil: true
  
    end
  end