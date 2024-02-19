class CreateOperators < ActiveRecord::Migration[6.0]
  def change
    create_table :operators do |t|
      t.integer :opr_nid
      t.string :oprcode
      t.string :name
      t.timestamps
    end
  end
end
