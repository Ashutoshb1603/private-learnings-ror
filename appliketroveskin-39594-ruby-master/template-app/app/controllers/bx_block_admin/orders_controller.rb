module BxBlockAdmin
    class OrdersController < ApplicationController
        before_action :current_user

        def index
            @q = BxBlockShoppingCart::Order.order('created_at DESC').ransack(params[:q])
            begin
                paginated_orders = pagy(@q.result, page: params[:page], items: 10)
            rescue Pagy::OverflowError => error
                render json: {message: "Page doesn't exist", error: error}, status: 404
            else 
                render json: BxBlockShoppingCart::OrderSerializer.new(paginated_orders.second, meta: {page_data: paginated_orders.first}).serializable_hash
            end
        end

    end
end