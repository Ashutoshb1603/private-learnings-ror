module BxBlockPayments
    class Wallet < ApplicationRecord
        self.table_name = :wallets

        belongs_to :account, class_name: 'AccountBlock::Account'

        has_many :wallet_transactions, class_name: 'BxBlockPayments::WalletTransaction'
        has_many :senders, class_name: 'BxBlockPayments::WalletTransaction', :foreign_key => 'sender_id'
        has_many :receivers, class_name: 'BxBlockPayments::WalletTransaction', :foreign_key => 'receiver_id'
        enum currency: { 'eur' => 1, 'gbp' => 2 }
        def self.make_payment(user, payment, amount)
            wallet = user.wallet
            new_amount = wallet.balance.to_d - amount.to_d
            wallet.with_lock do
                if wallet.decrement(:balance, amount.to_d).save
                    transaction = WalletTransaction.create(wallet_id: wallet.id, amount: amount, transaction_type: 'debit', status: 'success', comment: 'Balance Deducted!', currency: wallet.currency)
                    payment.set_paid
                else
                    payment.set_failed
                end
            end
            payment
        end

    end
end


