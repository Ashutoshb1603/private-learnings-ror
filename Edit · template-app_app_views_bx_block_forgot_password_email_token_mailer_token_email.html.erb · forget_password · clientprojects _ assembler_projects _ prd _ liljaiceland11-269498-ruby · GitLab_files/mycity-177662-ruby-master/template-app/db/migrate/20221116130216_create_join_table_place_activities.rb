class CreateJoinTablePlaceActivities < ActiveRecord::Migration[6.0]
  def change
    create_join_table :hidden_places, :activities do |t|
      t.index [:hidden_place_id, :activity_id], name: 'idx_place_activities'
      t.index [:activity_id, :hidden_place_id], name: 'idx_activities_places'
    end
  end
end
