class CreateConcern < ActiveRecord::Migration[6.0]
  def change
    create_table :concerns do |t|
      t.string :title

      t.timestamps
    end
  end
end
