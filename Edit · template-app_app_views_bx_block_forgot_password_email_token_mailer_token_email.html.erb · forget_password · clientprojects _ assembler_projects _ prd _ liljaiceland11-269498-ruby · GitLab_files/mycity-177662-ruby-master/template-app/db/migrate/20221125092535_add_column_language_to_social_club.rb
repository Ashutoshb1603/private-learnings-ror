class AddColumnLanguageToSocialClub < ActiveRecord::Migration[6.0]
  def up
    add_column :social_clubs, :language, :integer

    BxBlockSocialClubs::SocialClub.where(language: nil).each do |sc|
      sc.update(language: 0)
    end
  end

  def down
    remove_column :social_clubs, :language, :integer
  end
end
