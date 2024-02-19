module BxBlockShoppingCart
  class CartItemSerializer < BuilderBase::BaseSerializer

     attributes *[
      :product_id,
      :variant_id,
      :name,
      :quantity,
      :price,
      :total_price,
      :product_image_url
    ]

    attribute :currency do |object, params|
      @current_user = params[:current_user]
      @current_user.location.downcase == "ireland" ? "EUR" : "GBP"
    end

  end
end
