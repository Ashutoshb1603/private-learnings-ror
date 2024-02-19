class AddTherapistTypeToTherapistNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :therapist_notes, :therapist_type, :string, :default => "AccountBlock::Account"
  end
end
