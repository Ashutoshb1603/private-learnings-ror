class AddCoordinatesColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :pg_search_documents, :latitude, :float
    add_column :pg_search_documents, :longitude, :float

    add_index :pg_search_documents, [:latitude, :longitude]
  end
end
