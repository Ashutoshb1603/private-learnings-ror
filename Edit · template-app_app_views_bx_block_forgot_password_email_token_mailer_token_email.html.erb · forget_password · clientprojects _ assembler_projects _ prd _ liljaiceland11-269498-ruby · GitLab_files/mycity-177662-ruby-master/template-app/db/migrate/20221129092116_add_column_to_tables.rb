class AddColumnToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :social_clubs, :latitude, :string
    add_column :social_clubs, :longitude, :string

    add_column :club_events, :latitude, :string
    add_column :club_events, :longitude, :string
  end
end
