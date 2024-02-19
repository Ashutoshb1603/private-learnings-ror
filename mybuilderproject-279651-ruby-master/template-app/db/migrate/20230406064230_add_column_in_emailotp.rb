class AddColumnInEmailotp < ActiveRecord::Migration[6.0]
  def change
  	add_column :email_otps, :user_type, :string
  end
end
