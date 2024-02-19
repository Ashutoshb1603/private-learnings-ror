class AddCountryToSkinClinic < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_clinics, :country, :string
  end
end
