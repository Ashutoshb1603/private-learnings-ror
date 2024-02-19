# frozen_string_literal: true

module BxBlockOrderManagement
  class ApplyCoupon
    attr_accessor :coupon_code, :cart_value, :order

    def initialize(order, coupon, params)
      @coupon_code = coupon
      @order = order
      @cart_value = params[:cart_value].to_f
    end

    def call
      discount = if coupon_code.discount_type == "percentage"
        ((cart_value * coupon_code.discount) / 100)
      else
        coupon_code.discount
      end
      discount_price = (cart_value - discount)&.round(2)
      order.update(coupon_code_id: coupon_code.id, total: discount_price, applied_discount: discount)
    end
  end
end
