class AddAccountTypeToCustomerFavouriteProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :customer_favourite_products, :account_type, :string, :default => "AccountBlock::Account"
  end
end
