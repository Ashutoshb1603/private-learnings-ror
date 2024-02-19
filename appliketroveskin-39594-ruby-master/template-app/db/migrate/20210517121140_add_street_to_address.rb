class AddStreetToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :street1, :string
    add_column :addresses, :street2, :string
    add_column :addresses, :postcode, :integer

    remove_column :addresses, :address, :string
  end
end
