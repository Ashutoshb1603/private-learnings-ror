class CreateSkincareRoutines < ActiveRecord::Migration[6.0]
  def change
    create_table :skincare_routines do |t|
      t.integer :therapist_id
      t.integer :account_id
      t.integer :routine_type
      t.text :note

      t.timestamps
    end
  end
end
