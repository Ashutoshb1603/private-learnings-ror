module BxBlockSkinDiary
  class SkincareStepsSerializer < BuilderBase::BaseSerializer
    attributes :id, :step, :skincare_routine_id, :header, :created_at, :updated_at

    attribute :skincare_step_notes do |object|
      object.skincare_step_notes
    end

    attribute :products do |object, params|
      current_user = params[:current_user]
      shopify_products = params[:products]
      products = []
      object.skincare_products.each do |product|
        shopify_product = shopify_products.map{|p| p if p["title"].to_s == product.name}
        is_favourite = current_user.customer_favourite_products.pluck(:product_id).include? product.product_id
        in_cart = false
        in_cart = current_user.cart_items.pluck(:product_id).include? product.product_id if current_user.type != "AdminAccount"
        products << JSON.parse(product.to_json).merge(is_favourite: is_favourite, in_cart: in_cart, product_details: shopify_product)
      end
      products
    end



  end
end
