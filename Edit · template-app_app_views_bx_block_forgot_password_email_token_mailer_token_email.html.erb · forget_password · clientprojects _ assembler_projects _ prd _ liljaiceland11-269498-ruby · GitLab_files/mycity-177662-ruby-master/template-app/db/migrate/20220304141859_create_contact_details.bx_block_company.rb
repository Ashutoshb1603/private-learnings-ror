# This migration comes from bx_block_company (originally 20201214134940)
class CreateContactDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_details do |t|
      t.string :phone_number
      t.string :email
      t.text :address
      t.string :city
      t.string :state
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end
