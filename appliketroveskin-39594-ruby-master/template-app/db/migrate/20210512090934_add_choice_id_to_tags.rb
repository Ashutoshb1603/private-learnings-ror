class AddChoiceIdToTags < ActiveRecord::Migration[6.0]
  def change
    add_reference :tags, :choice, foreign_key: true
  end
end
