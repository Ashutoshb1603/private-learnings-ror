class AddNameColumnInPgSearch < ActiveRecord::Migration[6.0]
  def change
    add_column :pg_search_documents, :name, :string
    add_index :pg_search_documents, :name
  end
end
