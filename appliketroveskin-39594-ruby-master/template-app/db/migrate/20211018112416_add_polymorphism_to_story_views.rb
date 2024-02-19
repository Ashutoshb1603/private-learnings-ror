class AddPolymorphismToStoryViews < ActiveRecord::Migration[6.0]
  def change
    rename_column :story_views, :account_id, :accountable_id
    add_column :story_views, :accountable_type, :string
  end
end
