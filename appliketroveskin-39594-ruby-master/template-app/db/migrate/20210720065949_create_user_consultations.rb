class CreateUserConsultations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_consultations do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.integer :age
      t.string :email
      t.references :account, null: false, foreign_key: true
      t.integer :therapist_id
      t.datetime :booked_datetime

      t.timestamps
    end
  end
end
