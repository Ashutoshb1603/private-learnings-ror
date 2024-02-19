class RemoveTagReferenceFromChoiceTags < ActiveRecord::Migration[6.0]
  def change
      remove_reference :choice_tags, :tag
      add_column :choice_tags, :tag_id, :integer
  end
end
