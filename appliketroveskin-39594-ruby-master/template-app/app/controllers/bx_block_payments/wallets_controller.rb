module BxBlockPayments
    class WalletsController < ApplicationController

        def my_wallet(user)
            wallet = user.wallet
            wallet = Wallet.create(account_id: user.id) if user.wallet.nil?
            currency = user.location.downcase == "united kingdom" ? "gbp" : "eur"
            wallet.update(currency: currency) if wallet.balance == 0
            wallet
        end

        def refund(user, amount)
            wallet = user.wallet
            new_amount = wallet.balance - amount
            transaction = WalletTransaction.create(wallet_id: wallet.id, amount: amount, transaction_type: 'refund', status: 'in_progress', currency: wallet.currency)
            code = 200
            if new_amount < 0
                code = 400
                transaction.update(status: 'failed', comment: 'Insufficient Balance!')
            else
                wallet.update(balance: new_amount)
                transaction.update(status: 'success', comment: 'Balance Refunded!')
            end
            {transaction_id: transaction.id, message: transaction.comment, code: code}
        end

        def reverse_refund(user, amount, transaction_id)
            transaction = WalletTransaction.find(transaction_id)
            if transaction.transaction_type == 'refund'
                wallet = user.wallet
                new_amount = wallet.balance + amount
                transaction.update(comment: 'Refund Failed!', status: 'failed')
                wallet.update(balance: new_amount)
                response = {transaction_id: transaction.id, message: transaction.comment, code: 200}
            else
                response ={transaction_id: transaction.id, message: 'Invalid Transaction!', code: 400}
            end
            response
        end


        def debit(user, amount)
            wallet = user.wallet
            new_amount = wallet.balance - amount
            transaction = WalletTransaction.create(wallet_id: wallet.id, amount: amount, transaction_type: 'debit', status: 'in_progress', currency: wallet.currency)
            code = 200
            if new_amount < 0
                transaction.update(status: 'failed', comment: 'Insufficient Balance!')
                code = 400
            else
                wallet.with_lock do
                    wallet.decrement(:balance, amount).save
                end
                transaction.update(status: 'success', comment: 'Balance Deducted!')
            end
            {message: transaction.comment, code: code}
        end

        def credit(user, amount)
            wallet = user.wallet
            transaction = WalletTransaction.create(wallet_id: wallet.id, amount: amount, transaction_type: 'credit', status: 'in_progress', currency: wallet.currency)
            wallet.with_lock do
                wallet.increment(:balance, amount).save
            end
            transaction.update(status: 'success', comment: 'Balance credited!')
            wallet
        end

        def send_gift(sender, receiver, gift_params)
            senders_wallet = sender.wallet
            new_sender_amount = senders_wallet.balance - gift_params[:amount]
            receivers_wallet = receiver.wallet
            receivers_wallet = Wallet.create(account_id: receiver.id, currency: senders_wallet.currency) if receiver.wallet.nil?
            new_receiver_amount = receivers_wallet.balance + gift_params[:amount]
            reference = Time.now.to_i
            sender_transaction = WalletTransaction.create(wallet_id: senders_wallet.id, amount: gift_params[:amount], transaction_type: 'debit', status: 'in_progress', currency: senders_wallet.currency, sender_id: senders_wallet.id, receiver_id: receivers_wallet.id, reference_id: reference, custom_message: gift_params[:custom_message], gift_type_id: gift_params[:gift_type_id])
            code = 200
            if new_sender_amount < 0
                sender_transaction.update(status: 'failed', comment: 'Insufficient Balance!')
                code = 400
                response = {message: sender_transaction.comment, errors: {message: sender_transaction.comment}, code: code}
            else
                receiver_transaction = WalletTransaction.create(wallet_id: receivers_wallet.id, amount: gift_params[:amount], transaction_type: 'credit', status: 'in_progress', currency: receivers_wallet.currency, sender_id: senders_wallet.id, receiver_id: receivers_wallet.id, reference_id: reference, custom_message: gift_params[:custom_message], gift_type_id: gift_params[:gift_type_id])
                wallet = Wallet.find(senders_wallet.id)
                wallet.with_lock do
                    wallet.decrement(:balance, gift_params[:amount]).save
                end
                sender_transaction.update(status: 'success', comment: 'Gift sent!')

                wallet = Wallet.find(receivers_wallet.id)
                wallet.with_lock do
                    wallet.increment(:balance, gift_params[:amount]).save
                end
                receiver_transaction.update(status: 'success', comment: 'Gift received!')
                response = {message: sender_transaction.comment, code: code, data: {sender_transaction: sender_transaction, receiver_transaction: receiver_transaction}}
            end
            response
        end
    end
end