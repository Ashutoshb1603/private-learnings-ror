module BxBlockAdmin
    class TopSpendersSerializer < BuilderBase::BaseSerializer
      include JSONAPI::Serializer
      attributes :id, :name, :email, :total_spent, :orders_count, :user_type

      attribute :total_spent do |object|
        object.orders&.sum(:total_price)
      end

      attribute :orders_count do |object|
        object.orders&.count
      end

      attribute :user_type do |object|
        object.membership_plan[:plan_type]
      end
      
    end
  end