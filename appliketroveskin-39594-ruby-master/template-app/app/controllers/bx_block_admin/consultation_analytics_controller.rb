module BxBlockAdmin
    class ConsultationAnalyticsController < ApplicationController
        # before_action :shopify_products

        def index
            if params[:plan_type].present? && params[:plan_type] == "free"
                users = AccountBlock::Account.joins(:role).where('lower(roles.name) = ?', 'user')
                users = users.reject {|account| account.membership_plan[:plan_type] != "free" }
            elsif params[:plan_type].present?
                plan_type_value = BxBlockCustomisableusersubscriptions::MembershipPlan.plan_types[params[:plan_type]]
                users = AccountBlock::Account.joins(:membership_plans).where('membership_plans.end_date > ? and membership_plans.plan_type = ?', Time.now, plan_type_value)
            else
                users = AccountBlock::Account.all
            end

            if params[:therapist_id].present? && params[:therapist_type].present?
                therapist = params[:therapist_type].include?('Admin') ? AdminUser.find(params[:therapist_id].to_i) : AccountBlock::Account.find(params[:therapist_id].to_i)
                recommend_products = BxBlockCatalogue::RecommendedProduct.uniq_records_for_therapist(therapist, users.ids)
            else
                recommend_products = BxBlockCatalogue::RecommendedProduct.uniq_records(users.pluck(:id))
            end
            if params[:start_date].present? && params[:end_date].present?
                start_date = DateTime.parse(params[:start_date]).beginning_of_day
                end_date = DateTime.parse(params[:end_date]).end_of_day
                time_diff = (start_date..end_date)
                recommend_products = recommend_products.includes(:purchases).where('purchases.created_at' => time_diff).uniq
            end
            total_purchase = 0
            total_quantity = 0
            recommend_products.each do |recommended|
                price = recommended.price
                orders = recommended.purchases
                orders = recommended.purchases.filter_by_date(time_diff) if params[:start_date].present? && params[:end_date].present?
                total_quantity += orders.sum(:quantity)
                total_purchase += price*orders.sum(:quantity)
            end
            average_sale = total_quantity.blank? ? 0 : ((total_purchase.to_f/total_quantity).round(2))
            if params[:start_date].present? && params[:end_date].present?
                render json: BxBlockCatalogue::RecommendedProductSerializer.new(recommend_products, params: {time_diff: time_diff}).serializable_hash.merge({average_sale: average_sale, total_purchase: total_purchase})
            else
                render json: BxBlockCatalogue::RecommendedProductSerializer.new(recommend_products).serializable_hash.merge({average_sale: average_sale, total_purchase: total_purchase})
            end
        end
    end
end
