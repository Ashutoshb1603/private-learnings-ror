class AddClickCountInSkinClinics < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_clinics, :click_count, :integer, default: 0
  end
end
