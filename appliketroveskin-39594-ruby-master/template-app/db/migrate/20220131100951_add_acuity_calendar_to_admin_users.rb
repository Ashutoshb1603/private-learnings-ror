class AddAcuityCalendarToAdminUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :acuity_calendar, :string
  end
end
