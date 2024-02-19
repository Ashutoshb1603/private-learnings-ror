class AddAcuityCalendarToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :acuity_calendar, :string
  end
end
