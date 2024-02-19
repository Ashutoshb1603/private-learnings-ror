module BxBlockPayments
    class PlanSerializer < BuilderBase::BaseSerializer

      attributes *[
          :id,
          :price,
          :name,
          :duration,
          :period
      ]

      attribute :per_day_price do |object|
        object.period == "year" ? (object.price.to_f / (365 * object.duration)).round(2) : (object.price.to_f / (30 * object.duration)).round(2)
      end

    end
  end
