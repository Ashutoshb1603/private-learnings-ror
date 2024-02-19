# This migration comes from bx_block_company (originally 20201215071622)
class CreateCompanyCultures < ActiveRecord::Migration[6.0]
  def change
    create_table :company_cultures do |t|
      t.string :culture_names, array: true, default: []
      t.string :employee_benefits, array: true, default: []
      t.references :company, null: false, foreign_key: true
      t.timestamps
    end
  end
end
