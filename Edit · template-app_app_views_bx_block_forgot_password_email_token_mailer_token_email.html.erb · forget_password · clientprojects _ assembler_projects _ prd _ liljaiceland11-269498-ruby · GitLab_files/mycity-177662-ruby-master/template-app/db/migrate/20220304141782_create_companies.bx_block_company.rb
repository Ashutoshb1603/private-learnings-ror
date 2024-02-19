# This migration comes from bx_block_company (originally 20201117014636)
class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name

      t.timestamps
    end
  end
end
