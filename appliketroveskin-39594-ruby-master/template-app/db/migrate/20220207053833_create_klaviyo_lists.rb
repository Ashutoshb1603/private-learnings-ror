class CreateKlaviyoLists < ActiveRecord::Migration[6.0]
  def change
    create_table :klaviyo_lists do |t|
      t.integer :membership_list, :default => 1
      t.integer :not_active_since_6_months, :default => 1
      t.boolean :new, :default => false
      t.boolean :academy, :default => false
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
