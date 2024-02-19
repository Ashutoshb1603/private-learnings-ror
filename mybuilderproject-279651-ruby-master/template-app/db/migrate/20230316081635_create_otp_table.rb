class CreateOtpTable < ActiveRecord::Migration[6.0]
  def change
    create_table :otp_tables do |t|
    	t.string :full_phone_number
    	t.string :email
    	t.integer :pin 
    	t.boolean :activated, default: false
    	t.datetime :valid_until
    	t.timestamps
    end
  end
end
