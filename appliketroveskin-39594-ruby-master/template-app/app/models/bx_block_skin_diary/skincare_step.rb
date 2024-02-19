module BxBlockSkinDiary
  class SkincareStep < ApplicationRecord
    self.table_name = :skincare_steps
    belongs_to :skincare_routine, class_name: 'BxBlockSkinDiary::SkincareRoutine'
    has_many :skincare_products, :class_name => "BxBlockSkinDiary::SkincareProduct", dependent: :destroy
    has_many :skincare_step_notes, :class_name => "BxBlockSkinDiary::SkincareStepNote", dependent: :destroy
    accepts_nested_attributes_for :skincare_products, allow_destroy: true
    accepts_nested_attributes_for :skincare_step_notes, allow_destroy: true

    def self.skincare_products(skincare_step, current_user, shopify_products)
      products = []
      skincare_step.skincare_products.each do |product|
        shopify_product = shopify_products.map{|p| p if p["id"].to_s == product.product_id}
        is_favourite = current_user.customer_favourite_products.pluck(:product_id).include? product.product_id
        in_cart = current_user.cart_items.pluck(:product_id).include? product.product_id
        products << JSON.parse(product.to_json).merge(is_favourite: is_favourite, in_cart: in_cart, product_details: shopify_product)
      end
      products
    end

  end
end
