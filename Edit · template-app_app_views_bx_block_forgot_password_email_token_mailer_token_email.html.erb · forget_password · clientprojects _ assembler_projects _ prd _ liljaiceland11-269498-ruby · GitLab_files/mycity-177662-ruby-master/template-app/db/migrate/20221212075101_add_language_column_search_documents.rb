class AddLanguageColumnSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :pg_search_documents, :language, :string
    add_index :pg_search_documents, :language
  end
end
