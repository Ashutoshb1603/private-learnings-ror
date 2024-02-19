class AddColumnInSmsotp < ActiveRecord::Migration[6.0]
  def change
  	add_column :sms_otps, :user_type, :string
  end
end
