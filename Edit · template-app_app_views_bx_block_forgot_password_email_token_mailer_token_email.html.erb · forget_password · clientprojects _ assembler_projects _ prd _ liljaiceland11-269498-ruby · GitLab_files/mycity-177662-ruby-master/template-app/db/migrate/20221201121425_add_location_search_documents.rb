class AddLocationSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :pg_search_documents, :location, :text
    BxBlockHiddenPlaces::HiddenPlace.all&.map(&:update_search_document)
  end
end
