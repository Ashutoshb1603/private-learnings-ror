class AddGenderToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :gender, :string
  end
end
