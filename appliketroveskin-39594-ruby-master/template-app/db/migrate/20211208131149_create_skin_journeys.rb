class CreateSkinJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :skin_journeys do |t|
      t.text :before_image_url
      t.text :after_image_url
      t.string :message
      t.integer :account_id
      t.integer :therapist_id
      
      t.timestamps
    end
  end
end
