class CreateBxBlockAdminContactUs < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_us do |t|
      t.string :name 
      t.string :email 
      t.text :description
      
      t.timestamps
    end
  end
end
