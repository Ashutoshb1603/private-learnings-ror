module BxBlockPayments
    class WalletSerializer < BuilderBase::BaseSerializer

      attributes *[
          :id,
          :balance,
          :currency,
          :wallet_transactions
      ]

      attribute :wallet_transactions do |object|
        BxBlockPayments::WalletTransactionsSerializer.new(object.wallet_transactions.order('created_at DESC')).serializable_hash
      end
    end
  end
  