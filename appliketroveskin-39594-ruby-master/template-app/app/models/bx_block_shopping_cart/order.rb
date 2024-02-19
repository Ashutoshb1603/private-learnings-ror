module BxBlockShoppingCart
  class Order < ApplicationRecord
    include Wisper::Publisher
    self.table_name = :shopping_cart_orders

    # BUFFER_TIME = 20 #in minute

    #order status are
    #upcomming = 'scheduled', ongoing = 'on_going', history = 'cancelled or completed

    belongs_to :address, class_name: 'BxBlockAddress::Address'
    has_many :line_items, dependent: :destroy, class_name: "BxBlockShoppingCart::LineItem"
    accepts_nested_attributes_for :line_items, allow_destroy: true
    # belongs_to :service_provider,
    #            class_name: 'AccountBlock::Account',
    #            foreign_key: :service_provider_id
    belongs_to :customer, class_name: 'AccountBlock::Account', foreign_key: :customer_id
    belongs_to :coupon, class_name: 'BxBlockCoupons::Coupon', optional: true
    has_one :discount_code_usage, class_name: "BxBlockShopifyintegration::DiscountCodeUsage"
    # has_one :booked_slot,
    #         class_name: "BxBlockAppointmentManagement::BookedSlot",
    #         dependent: :destroy

    # has_and_belongs_to_many :sub_categories,
    #                         class_name: 'BxBlockCategories::SubCategory',
    #                         join_table: :order_services, foreign_key: :shopping_cart_order_id

    enum :order_type => { 'instant booking' => 0, 'advance booking' => 1 }
    enum :financial_status => {'pending'  => 1, 'paid' => 2, 'refunded' => 3, 'partially_paid' => 4}
    enum :currency => {'eur' => 1, 'gbp' => 2}
    ransacker :financial_status, formatter: proc {|v| financial_statuses[v]}
    ransacker :order_type, formatter: proc {|v| order_types[v]}
    # validates_presence_of :booking_date, :slot_start_time, :total_fees, :order_type
    # validate :check_service_provide, if: Proc.new {|a|a.new_record?}
    # validate :check_major_services, if: Proc.new {|a|a.new_record?}
    # validate :check_available_slots, if: Proc.new {|a|a.new_record?}
    # validate :check_order_status, if: Proc.new {|a| !a.new_record?}
    # validate :instant_booking_slots,
    #          if: Proc.new { |order| order.order_type == 'instant booking' && order.new_record? }
    # validate :advance_booking_slots,
    #          if: Proc.new { |order| order.order_type == 'advance booking' && order.new_record? }

    # accepts_nested_attributes_for :sub_categories

  end
end
