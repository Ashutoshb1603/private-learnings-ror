# This migration comes from bx_block_account_details (originally 20201117034450)
class CreateAdditionalInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :additional_infos do |t|
      t.references :account, null: false, foreign_key: true
      t.string :religion
      t.string :caste
      t.string :birth_place
      t.string :house_type
      t.boolean :available_as_freelancer
      t.integer :rate_per_hour

      t.timestamps
    end
  end
end
