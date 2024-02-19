class AddFieldsToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :language, :string
    add_column :accounts, :service_and_policy, :boolean
    add_column :accounts, :term_and_condition, :boolean
    add_column :accounts, :age_confirmation, :boolean
    add_column :accounts, :interests, :text

  end
end
