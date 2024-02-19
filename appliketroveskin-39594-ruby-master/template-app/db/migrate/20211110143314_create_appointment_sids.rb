class CreateAppointmentSids < ActiveRecord::Migration[6.0]
  def change
    create_table :appointment_sids do |t|
      t.string :appointment_id
      t.string :sid

      t.timestamps
    end
  end
end
