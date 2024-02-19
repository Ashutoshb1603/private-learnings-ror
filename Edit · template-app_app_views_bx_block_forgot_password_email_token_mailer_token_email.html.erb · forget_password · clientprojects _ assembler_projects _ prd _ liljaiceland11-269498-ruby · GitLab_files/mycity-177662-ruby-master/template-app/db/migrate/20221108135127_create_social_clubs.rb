class CreateSocialClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :social_clubs do |t|
      t.integer :account_id
      t.integer :interests, array:true, default:[]
      t.text :description
      t.text :community_rules
      t.string :location
      t.boolean :is_visible, default: false
      t.integer :chat_channels, array:true, default:[]
      t.integer :user_capacity
      t.string :bank_name
      t.string :bank_account_name
      t.string :bank_account_number
      t.string :routing_code
      t.integer :max_channel_count
      t.integer :status, default: 0
      t.string :fee_currency
      t.decimal :fee_amount_cents, precision: 8, scale: 2


      t.timestamps
    end
  end
end
