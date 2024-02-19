class CreateCrewAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :crew_accounts do |t|
    	t.string :name
    	t.string :operator_name
    	t.string :status
    	t.string :account_number
    	t.boolean :default_account, default: false
    	t.bigint :crew_id

    	t.timestamps
    end
  end
end
