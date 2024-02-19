class AddColumnInOtptable < ActiveRecord::Migration[6.0]
  def change
  	add_column :otp_tables, :user_type, :string
  end
end
