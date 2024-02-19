module BxBlockShoppingCart
    class CartItemWorker
        include Sidekiq::Worker

        def perform()
            cartItems = CartItem.where("created_at <= ?", (Date.today - 30).to_datetime)
            cartItems.destroy_all if cartItems.present?
        end
    end
end