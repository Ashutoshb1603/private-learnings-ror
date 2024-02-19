class AddAddressToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :address, :string
  end
end
