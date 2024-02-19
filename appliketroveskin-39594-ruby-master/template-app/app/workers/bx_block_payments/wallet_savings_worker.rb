module BxBlockPayments
    class WalletSavingsWorker
        include Sidekiq::Worker

        def perform()
            debit = BxBlockPayments::WalletTransaction.transaction_types["debit"]
            wallets = BxBlockPayments::Wallet.where.not(balance: 0).includes(:wallet_transactions)
            wallets.each do |wallet|
                debit_transaction = wallet.wallet_transactions.where(transaction_type: debit).order(created_at: :desc)&.first&.created_at
                if debit_transaction.nil? or ((Time.now - debit_transaction) > 1.day && ((Time.now - debit_transaction).to_i/86400)%30 == 0)
                    account = wallet.account
                    date = wallet&.wallet_transactions.where('transaction_type= ?', debit).order(created_at: :desc).first&.created_at || wallet.created_at
                    payload_data = {account: account, notification_key: 'wallet', inapp: true, push_notification: true, all: false, type: 'wallet', notification_for: 'wallet', key: 'wallet'}
                    BxBlockPushNotifications::FcmSendNotification.new("You have saved #{wallet.balance} since #{date.strftime("%d %B %Y")}! Want to use your balance? ", "Want to use your balance?", account&.device_token, payload_data).call
                end
            end
        end
    end
end