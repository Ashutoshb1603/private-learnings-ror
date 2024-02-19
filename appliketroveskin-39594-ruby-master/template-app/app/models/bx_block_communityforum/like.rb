module BxBlockCommunityforum
  class Like < ApplicationRecord

    self.table_name = :likes

    # belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :accountable, polymorphic: true
    belongs_to :objectable, polymorphic: true

    after_create :log_activity
    before_destroy :remove_activity

    def log_activity
      Activity.find_or_create_by(accountable_id: self.accountable_id, accountable_type: self.accountable_type, action: 'liked', objectable: self.objectable, concern_mail_id: self.objectable.accountable.id)
    end

    def remove_activity
      Activity.where(accountable_id: self.accountable_id, action: 'liked', objectable: self.objectable).destroy_all
    end

  end
end