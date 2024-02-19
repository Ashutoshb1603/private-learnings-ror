class CreateCollectionViews < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_views do |t|
      t.string :collection_id
      t.references :accountable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
