class AddNotificationFieldsToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :last_update_log, :date
    add_column :accounts, :last_notification, :date
    AccountBlock::Account.all.each do |account|
      account.update(last_update_log: account&.user_images&.last&.created_at&.to_date, last_notification: Date.today)
    end
  end
end
