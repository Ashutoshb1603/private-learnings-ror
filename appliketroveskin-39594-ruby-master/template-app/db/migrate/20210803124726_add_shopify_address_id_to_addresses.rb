class AddShopifyAddressIdToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :shopify_address_id, :string
  end
end
