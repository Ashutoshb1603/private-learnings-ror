class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :title
      t.integer :status, :default => 1

      t.timestamps
    end
  end
end
