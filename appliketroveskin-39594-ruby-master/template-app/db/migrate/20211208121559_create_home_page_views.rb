class CreateHomePageViews < ActiveRecord::Migration[6.0]
  def change
    create_table :home_page_views do |t|
      t.references :accountable, polymorphic: true, null: false
      t.integer :view_count, :default => 0

      t.timestamps
    end
  end
end
