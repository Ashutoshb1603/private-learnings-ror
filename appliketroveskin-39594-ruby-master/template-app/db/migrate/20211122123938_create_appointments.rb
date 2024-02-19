class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :appointment_id
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.datetime :date
      t.string :time
      t.string :endtime
      t.decimal :price
      t.string :appointment_type
      t.string :calendar
      t.string :calendar_id
      t.boolean :canceled, :default => false
      t.integer :account_id

      t.timestamps
    end
  end
end
