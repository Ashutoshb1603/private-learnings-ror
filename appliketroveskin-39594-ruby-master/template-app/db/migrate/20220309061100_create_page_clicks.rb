class CreatePageClicks < ActiveRecord::Migration[6.0]
  def change
    create_table :page_clicks do |t|
      t.integer :click_count, :default => 0
      t.references :accountable, polymorphic: true, null: false
      t.references :objectable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
