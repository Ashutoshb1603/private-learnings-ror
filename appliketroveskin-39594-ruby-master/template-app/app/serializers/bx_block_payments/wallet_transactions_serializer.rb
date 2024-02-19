module BxBlockPayments
    class WalletTransactionsSerializer < BuilderBase::BaseSerializer

      attributes *[
          :id,
          :wallet_id,
          :amount,
          :transaction_type,
          :status,
          :comment,
          :custom_message,
          :gift_type,
          :transaction_date,
          :currency
      ]

      attribute :transaction_date do |object|
        object.created_at.strftime('%m-%d-%Y : %H-%M')
      end

      attribute :gift_type do |object|
        object.gift_type.name unless object.gift_type.nil?
      end

      attribute :sender do |object|
        object&.sender&.account&.email
      end 

      attribute :image do |object|
        gift_type = object.gift_type
        receiver = object&.receiver&.account
        image = (gift_type&.free_user_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(gift_type.free_user_image, only_path: true) : "") if receiver&.membership_plan.try(:plan_type) == "free"
        image = (gift_type&.gg_user_image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(gift_type.gg_user_image, only_path: true) : "") if receiver&.membership_plan.try(:plan_type) != "free"
        image
      end

    end
  end
  