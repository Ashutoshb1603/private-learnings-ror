class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :reportable, polymorphic: true, null: false
      t.references :accountable, polymorphic: true, null: false
      t.text :description

      t.timestamps
    end
  end
end
