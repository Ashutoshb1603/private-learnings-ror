class CreateKeyPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :key_points do |t|
      t.string :description
      t.integer :academy_id

      t.timestamps
    end
  end
end
