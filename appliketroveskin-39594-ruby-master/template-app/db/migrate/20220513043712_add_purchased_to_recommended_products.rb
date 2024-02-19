class AddPurchasedToRecommendedProducts < ActiveRecord::Migration[6.0]
  def change
    BxBlockCatalogue::DeleteDuplicateData.call
    add_column :recommended_products, :purchased, :boolean, default: false
    add_index :recommended_products, [:account_id, :product_id, :therapist_id], unique: true, name: 'my_index'
    BxBlockCatalogue::RecommendedProduct.update_all(purchased: true)
  end
end
