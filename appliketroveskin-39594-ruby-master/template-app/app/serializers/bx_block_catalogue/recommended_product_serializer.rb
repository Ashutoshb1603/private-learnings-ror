module BxBlockCatalogue
    class RecommendedProductSerializer < BuilderBase::BaseSerializer
      # attributes :id, :appointment_id, :firstname, :lastname, :phone, :email, :date, :time, :endtime, :price, :appointment_type, :calendar, :calendar_id, :canceled, :account_id
      # attribute :id
      attribute :firstname do |object|
        object&.account&.first_name
      end
      attribute :lastname do |object|
        object&.account&.last_name
      end
      attribute :date do |object, params|
        if params[:time_diff].present?
          object&.purchases.where(created_at: params[:time_diff]).last.created_at
        else
          object.purchases.last.created_at
        end
      end
      attribute :time do |object, params|
        if params[:time_diff].present?
          object&.purchases.where(created_at: params[:time_diff]).last.created_at.strftime('%I:%M%p')
        else
          object.purchases.last.created_at.strftime('%I:%M%p')
        end
      end

      attribute :quantity do |object, params|
        if params[:time_diff].present?
          object.purchases.filter_by_date(params[:time_diff]).sum(:quantity)
        else
          object.purchases.sum(:quantity)
        end
      end

      attribute :price do |object|
        object&.price
      end
      attribute :account_id do |object|
        object&.account_id
      end
    end
  end
  
