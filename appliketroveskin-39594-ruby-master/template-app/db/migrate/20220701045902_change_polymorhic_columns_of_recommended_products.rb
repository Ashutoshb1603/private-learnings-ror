class ChangePolymorhicColumnsOfRecommendedProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :recommended_products, :parentable, polymorphic: true, index: true
    remove_column :recommended_products, :therapist_id, :integer
    remove_column :recommended_products, :quantity, :integer
  end
end


