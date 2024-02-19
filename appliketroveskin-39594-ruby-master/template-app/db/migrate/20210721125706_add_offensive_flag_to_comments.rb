class AddOffensiveFlagToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :offensive, :boolean, :default => false
  end
end
