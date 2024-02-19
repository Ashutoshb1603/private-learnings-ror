ActiveAdmin.register BxBlockShoppingCart::Order, as: 'Orders' do
    menu label: "Shopify Orders - View"
    actions :all, :except => [:edit, :destroy, :new]
    
    index do
    #   selectable_column 
      column 'Order id', :order_id
      column 'Customer' do |order|
        order.customer&.name
      end
      column :total_price
      column :status
      column 'Order date' do |order|
        order.created_at.strftime("%d %B %Y")
      end
      column :financial_status
      actions
    end

    filter :id
    filter :products
    filter :status, as: :select

    show do |order|
        attributes_table do
            row "Order id" do
                order.order_id
            end
            row 'Customer' do
                order.customer&.name
            end

            row :email
            row :phone
            
            row :discount
            row "Total Tax (#{order.tax_title} included)"  do
                order.total_tax
            end
            row :subtotal_price
            row "Shipping Charges (#{order.shipping_title})" do
                order.shipping_charges
            end
            row :total_price
            row :status
            row :financial_status
            row :transaction_id

            row 'Order date' do
                order.created_at.strftime("%d %B %Y")
            end

            div class: 'panel' do
                h3 'Products'
                div class: 'attributes_table' do
                    table do
                        tr class: 'table-header' do
                            th 'Product Id'
                            th 'Variant Id'
                            th 'Name'
                            th 'Total Discount'
                            th 'Quantity'
                            th 'Price'
                            th 'Total Price'
                        end
                        order.line_items.each do |line_item|
                            tr do
                                td line_item.product_id
                                td line_item.variant_id
                                td line_item.name
                                td line_item.total_discount
                                td line_item.quantity
                                td line_item.price
                                td line_item.quantity * line_item.price
                            end
                        end
                    end
                end
            end
        end
    end
end
  
