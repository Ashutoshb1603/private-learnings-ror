class AddAppointmentIdToAdvertisements < ActiveRecord::Migration[6.0]
  def change
    add_column :advertisements, :appointment_id, :string
  end
end
