class CreateTherapistNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :therapist_notes do |t|
      t.integer :therapist_id
      t.integer :account_id
      t.text :description

      t.timestamps
    end
  end
end
