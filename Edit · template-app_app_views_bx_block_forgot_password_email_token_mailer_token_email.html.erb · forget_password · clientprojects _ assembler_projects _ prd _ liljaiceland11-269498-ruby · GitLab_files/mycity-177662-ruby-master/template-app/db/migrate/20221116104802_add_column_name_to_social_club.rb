class AddColumnNameToSocialClub < ActiveRecord::Migration[6.0]
  def up
    add_column :social_clubs, :name, :string

    BxBlockSocialClubs::SocialClub.where(name: nil).each do |sc|
      sc.update(name: "sc_#{sc.id}")
    end
    change_column_null :social_clubs, :name, false
  end

  def down
    remove_column :social_clubs, :name, :string
  end
end
