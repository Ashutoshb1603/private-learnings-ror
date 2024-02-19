class CreateSkincareSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :skincare_steps do |t|
      t.text :step
      t.integer :skincare_routine_id

      t.timestamps
    end
  end
end
