class AddTherapistTypeToSkincareRoutines < ActiveRecord::Migration[6.0]
  def change
    add_column :skincare_routines, :therapist_type, :string, :default => "AccountBlock::Account"
  end
end
