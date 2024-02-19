class AddColumnsToRecommendedProducts < ActiveRecord::Migration[6.0]
  def up
    add_column :recommended_products, :title, :string
    add_column :recommended_products, :price, :integer, default: 0
    add_column :recommended_products, :quantity, :integer, default: 0
    remove_index :recommended_products, name: 'my_index'
    shopify = BxBlockShopifyintegration::ShopifyProductsController.new({country: "Ireland"})
    BxBlockCatalogue::RecommendedProduct.update_all(title: "Blank")
    BxBlockCatalogue::RecommendedProduct.all.each do |recommended|
      begin
        prod = shopify.product_show(recommended[:product_id], "Ireland")
        prod = shopify.product_show(recommended[:product_id], "UK") if prod['errors'].present?
        orders = BxBlockShoppingCart::Order.where(customer_id: recommended[:account_id], financial_status: 2)
        @price = 0
        @quantity = 0
        orders.each do |order|
          lines = order.line_items.where(name: prod['product']['title'])
          lines.each do |line|
            @price += line.price*line.quantity
            @quantity += line.quantity
          end
        end
        recommended.update(title: prod['product']['title'], price: @price, quantity: @quantity) if prod['product']['title'].present?
      rescue => e
        return
      end
    end
    change_column_null :recommended_products, :title, false
    add_index :recommended_products, [:account_id, :title, :therapist_id], unique: true, name: 'unique_index'
  end
  def down
    remove_column :recommended_products, :title, :string
    remove_column :recommended_products, :price, :integer
    remove_column :recommended_products, :quantity, :integer
    add_index :recommended_products, [:account_id, :product_id, :therapist_id], name: 'my_index'
  end
end
