class AddStatusToPgSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :pg_search_documents, :status, :string
    add_index :pg_search_documents, :status

    BxBlockAnalytics9::SearchDocument.destroy_all
    
    BxBlockHiddenPlaces::HiddenPlace.all.map(&:update_pg_search_document)
    BxBlockSocialClubs::SocialClub.all.map(&:update_pg_search_document)
    BxBlockClubEvents::ClubEvent.all.map(&:update_pg_search_document)
  end
end
