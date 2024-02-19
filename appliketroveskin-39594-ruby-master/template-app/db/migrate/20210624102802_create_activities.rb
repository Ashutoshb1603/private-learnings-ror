class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.integer :account_id
      t.integer :action
      t.references :objectable, polymorphic: true

      t.timestamps
    end
  end
end
