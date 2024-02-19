class CreateGooglePlaceIntegrations < ActiveRecord::Migration[6.0]
  def change
    unless ActiveRecord::Base.connection.table_exists?('google_place_integrations')
      create_table :google_place_integrations do |t|
        t.string :city
        t.string :latitude
        t.string :longitude
        t.text :page_token
        t.timestamps
      end

      add_index :google_place_integrations, :city
      add_index :google_place_integrations, [:latitude, :longitude]
    end
  end
end
