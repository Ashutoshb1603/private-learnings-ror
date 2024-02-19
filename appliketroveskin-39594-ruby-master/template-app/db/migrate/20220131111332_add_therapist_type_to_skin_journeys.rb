class AddTherapistTypeToSkinJourneys < ActiveRecord::Migration[6.0]
  def change
    add_column :skin_journeys, :therapist_type, :string, :default => "AccountBlock::Account"
  end
end
