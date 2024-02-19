class AddReferenceToDevices < ActiveRecord::Migration[6.0]
  def change
    add_reference :devices, :admin_user
  end
end
