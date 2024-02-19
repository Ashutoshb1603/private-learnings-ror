module BxBlockPayments
    class WalletTransaction < ApplicationRecord
        self.table_name = :wallet_transactions

        belongs_to :wallet, class_name: 'BxBlockPayments::Wallet'
        belongs_to :sender, class_name: 'BxBlockPayments::Wallet', foreign_key: :sender_id, optional: true
        belongs_to :receiver, class_name: 'BxBlockPayments::Wallet', foreign_key: :receiver_id, optional: true

        belongs_to :gift_type, class_name: 'BxBlockPayments::GiftType', optional: true
        
        enum transaction_type: {'debit': 1, 'credit': 2, 'refund': 3}
        enum status: {'success': 1, 'failed': 2, 'in_progress': 3}
        enum currency: { 'eur' => 1, 'gbp' => 2 }
        
    end
end
