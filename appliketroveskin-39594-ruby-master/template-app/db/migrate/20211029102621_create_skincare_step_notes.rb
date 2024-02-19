class CreateSkincareStepNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :skincare_step_notes do |t|
      t.text :comment
      t.integer :skincare_step_id

      t.timestamps
    end
  end
end
