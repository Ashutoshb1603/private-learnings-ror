class CreateBxBlockExplanationTextExplanationTexts < ActiveRecord::Migration[6.0]
  def change
    create_table :explanation_texts do |t|
      t.string :section_name
      t.text :value
      t.string :area_name

      t.timestamps
    end
  end
end
