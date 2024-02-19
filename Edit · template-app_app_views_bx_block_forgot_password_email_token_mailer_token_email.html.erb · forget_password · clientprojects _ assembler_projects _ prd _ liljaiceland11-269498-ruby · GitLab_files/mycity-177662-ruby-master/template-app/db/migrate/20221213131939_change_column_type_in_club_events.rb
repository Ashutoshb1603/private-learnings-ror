class ChangeColumnTypeInClubEvents < ActiveRecord::Migration[6.0]
  def change
    BxBlockClubEvents::ClubEvent.all.map{|ce| ce.update(latitude: ce.latitude&.to_f, longitude: ce.longitude&.to_f)}
    change_column :club_events, :latitude, 'float USING CAST(latitude AS float)'
    change_column :club_events, :longitude, 'float USING CAST(longitude AS float)'
  end
end
