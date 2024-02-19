class MigratePreferredLanguage < ActiveRecord::Migration[6.0]
  def change
    AccountBlock::Account.find_each do |account|
      account.update_columns(preferred_language: account.language)
    end
  end
end
