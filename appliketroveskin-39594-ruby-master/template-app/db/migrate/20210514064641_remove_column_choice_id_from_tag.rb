class RemoveColumnChoiceIdFromTag < ActiveRecord::Migration[6.0]
  def change
    remove_reference :tags, :choice
  end
end
