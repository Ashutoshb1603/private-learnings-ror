class AddNewColumnsInVariousTable < ActiveRecord::Migration[6.0]
  def change
    add_column :hidden_places, :city, :string
    add_column :social_clubs, :city, :string
    add_column :club_events, :city, :string
    add_column :pg_search_documents, :city, :string
  end
end
