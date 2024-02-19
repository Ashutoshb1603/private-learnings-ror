module AccountBlock
	class AccountsInterest < ApplicationRecord
    include Wisper::Publisher
		self.table_name = :accounts_interests

		belongs_to :account, class_name: "AccountBlock::Account", optional: true
		belongs_to :interest, class_name: "BxBlockInterests::Interest", optional: true
	end
end
