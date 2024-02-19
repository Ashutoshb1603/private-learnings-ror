class CreateActiveHours < ActiveRecord::Migration[6.0]
  def change
    create_table :active_hours do |t|
      t.references :account, null: false, foreign_key: true
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
