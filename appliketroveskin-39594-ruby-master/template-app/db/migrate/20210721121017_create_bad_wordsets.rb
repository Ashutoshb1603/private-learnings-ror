class CreateBadWordsets < ActiveRecord::Migration[6.0]
  def change
    create_table :bad_wordsets do |t|
      t.string :words

      t.timestamps
    end
  end
end
