class CreateBxBlockInterestsInterests < ActiveRecord::Migration[6.0]
  def change
    create_table :interests do |t|

      t.string :name

      t.timestamps
    end
  end
end
