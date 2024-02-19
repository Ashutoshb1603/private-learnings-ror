class AddGooglePlaceUrlSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    unless column_exists? :pg_search_documents, :google_place_url
      add_column :pg_search_documents, :google_place_url, :text
    end
  end
end
