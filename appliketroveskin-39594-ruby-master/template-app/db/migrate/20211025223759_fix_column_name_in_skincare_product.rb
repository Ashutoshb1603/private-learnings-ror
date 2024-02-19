class FixColumnNameInSkincareProduct < ActiveRecord::Migration[6.0]
  def change
    rename_column :skincare_products, :skincare_routine_id, :skincare_step_id
  end
end
