class AddAccountTypeToCustomerChats < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :therapist_type, :string, :default => "AccountBlock::Account"
  end
end
