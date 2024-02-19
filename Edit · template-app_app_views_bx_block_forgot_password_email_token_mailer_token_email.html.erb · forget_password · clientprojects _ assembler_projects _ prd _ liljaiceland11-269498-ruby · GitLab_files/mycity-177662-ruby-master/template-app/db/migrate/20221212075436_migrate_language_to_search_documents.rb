class MigrateLanguageToSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    BxBlockSocialClubs::SocialClub.all.map{|a| a.update_pg_search_document}
  end
end
