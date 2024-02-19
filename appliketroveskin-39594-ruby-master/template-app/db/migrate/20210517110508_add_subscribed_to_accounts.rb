class AddSubscribedToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :is_subscribed_to_mailing, :boolean, :default => false
  end
end
