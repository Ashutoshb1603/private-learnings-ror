class CreateRefunds < ActiveRecord::Migration[6.0]
  def change
    create_table :refunds do |t|
      t.string :charge_id
      t.string :refund_id

      t.timestamps
    end
  end
end
