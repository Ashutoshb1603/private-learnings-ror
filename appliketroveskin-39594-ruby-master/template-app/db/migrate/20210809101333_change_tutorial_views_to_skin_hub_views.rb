class ChangeTutorialViewsToSkinHubViews < ActiveRecord::Migration[6.0]
  def change
    rename_table :tutorial_views, :skin_hub_views
    rename_table :tutorial_likes, :skin_hub_likes
  end
end
