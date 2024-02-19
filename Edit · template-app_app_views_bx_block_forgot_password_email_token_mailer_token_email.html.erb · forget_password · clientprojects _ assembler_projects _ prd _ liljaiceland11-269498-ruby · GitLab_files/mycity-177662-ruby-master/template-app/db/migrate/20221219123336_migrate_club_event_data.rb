class MigrateClubEventData < ActiveRecord::Migration[6.0]
  def change
    BxBlockClubEvents::ClubEvent.all.map(&:update_pg_search_document)
  end
end
