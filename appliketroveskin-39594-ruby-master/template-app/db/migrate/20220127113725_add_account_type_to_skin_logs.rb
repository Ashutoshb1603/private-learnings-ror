class AddAccountTypeToSkinLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :account_choice_skin_logs, :account_type, :string, :default => "AccountBlock::Account"
    add_column :user_images, :account_type, :string, :default => "AccountBlock::Account"
  end
end
