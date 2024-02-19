# This migration comes from bx_block_automatic_renewals (originally 20210114152227)
class CreateAutomaticRenewals < ActiveRecord::Migration[6.0]
  def change
    create_table :automatic_renewals do |t|
      t.references :account, null: false, foreign_key: true
      t.string :subscription_type
      t.boolean :is_auto_renewal, default: false
      t.timestamps
    end
  end
end
