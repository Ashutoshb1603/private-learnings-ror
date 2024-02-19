class AddClubTypeToSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :pg_search_documents, :club_type, :string
    add_index :pg_search_documents, :club_type

    BxBlockSocialClubs::SocialClub.all.each{|club| club.update_search_document }
  end
end
