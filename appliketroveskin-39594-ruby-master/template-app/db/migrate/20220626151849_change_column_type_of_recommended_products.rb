class ChangeColumnTypeOfRecommendedProducts < ActiveRecord::Migration[6.0]
  def up
    change_column :recommended_products, :price, :decimal
    add_column :recommended_products, :therapist_type, :string, default: "AccountBlock::Account"
  end

  def down
    change_column :recommended_products, :price, :integer
    remove_column :recommended_products, :therapist_type, :string
  end
end
