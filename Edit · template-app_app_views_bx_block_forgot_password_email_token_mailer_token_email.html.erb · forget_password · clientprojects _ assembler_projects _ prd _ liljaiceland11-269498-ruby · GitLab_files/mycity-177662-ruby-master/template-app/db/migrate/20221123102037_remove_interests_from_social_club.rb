class RemoveInterestsFromSocialClub < ActiveRecord::Migration[6.0]
  def change
    remove_column :social_clubs, :interests, :integer
    create_join_table :interests, :social_clubs, join_table: "interests_social_clubs"
  end
end
