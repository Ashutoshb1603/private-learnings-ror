class CreateGiftTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :gift_types do |t|
      t.string :name
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
