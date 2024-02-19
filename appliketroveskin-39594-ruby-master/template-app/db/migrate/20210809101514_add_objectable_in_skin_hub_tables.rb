class AddObjectableInSkinHubTables < ActiveRecord::Migration[6.0]
  def change
    rename_column :skin_hub_views, :tutorial_id, :objectable_id
    rename_column :skin_hub_likes, :tutorial_id, :objectable_id
    add_column :skin_hub_views, :objectable_type, :string
    add_column :skin_hub_likes, :objectable_type, :string
  end
end
