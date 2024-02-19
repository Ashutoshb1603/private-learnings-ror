class GenerateDataSearchDocuments < ActiveRecord::Migration[6.0]
  def change
    BxBlockHiddenPlaces::HiddenPlace.all&.map(&:update_search_document)
  end
end
