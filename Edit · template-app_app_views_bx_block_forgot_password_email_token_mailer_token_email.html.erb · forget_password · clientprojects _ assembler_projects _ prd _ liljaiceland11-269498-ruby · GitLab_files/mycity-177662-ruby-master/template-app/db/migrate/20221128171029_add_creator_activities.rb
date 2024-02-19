class AddCreatorActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :account_id, :integer
    add_column :travel_items, :account_id, :integer
    add_column :weathers, :account_id, :integer
    add_column :interests, :created_by, :integer
  end
end
