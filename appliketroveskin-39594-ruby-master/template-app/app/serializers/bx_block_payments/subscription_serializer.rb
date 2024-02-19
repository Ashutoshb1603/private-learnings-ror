module BxBlockPayments
  class SubscriptionSerializer < BuilderBase::BaseSerializer
    # include FastJsonapi::ObjectSerializer
    attributes *[
        :id,
        :account,
        :amount,
        :frequency,
        :next_payment_date,
        :payment_from,
        :is_cancelled,
        :started_on
    ]

    attributes :started_on do |object|
      object.created_at.strftime("%Y-%m-%d")
    end

  end
end
