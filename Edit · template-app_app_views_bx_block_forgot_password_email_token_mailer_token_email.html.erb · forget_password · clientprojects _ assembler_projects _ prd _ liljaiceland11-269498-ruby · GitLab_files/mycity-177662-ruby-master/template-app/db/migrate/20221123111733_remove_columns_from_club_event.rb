class RemoveColumnsFromClubEvent < ActiveRecord::Migration[6.0]
  def change
    remove_column :club_events, :activity_ids, :integer
    remove_column :club_events, :equipment_ids, :integer
    create_join_table :activities, :club_events, join_table: "activities_club_events"
    create_join_table :equipments, :club_events, join_table: "equipments_club_events"
  end
end
