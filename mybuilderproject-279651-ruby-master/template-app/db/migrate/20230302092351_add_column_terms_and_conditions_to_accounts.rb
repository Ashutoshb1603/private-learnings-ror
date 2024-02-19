class AddColumnTermsAndConditionsToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :terms_and_conditions, :boolean, default: false
  end
end
