class AddClinicLinkToSkinClinics < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_clinics, :clinic_link, :string
  end
end
