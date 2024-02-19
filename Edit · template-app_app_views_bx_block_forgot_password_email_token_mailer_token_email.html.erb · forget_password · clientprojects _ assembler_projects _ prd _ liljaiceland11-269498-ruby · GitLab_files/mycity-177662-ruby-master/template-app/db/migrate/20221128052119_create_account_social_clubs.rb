class CreateAccountSocialClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :account_social_clubs do |t|
      t.references :account, null: false, foreign_key: true
      t.references :social_club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
