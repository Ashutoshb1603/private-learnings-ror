class ChangeColumnsInPlans < ActiveRecord::Migration[6.0]
  def change
    rename_column :plans, :price_cents, :price
    remove_column :plans, :stripe_plan_name
    remove_column :plans, :interval
    add_column :plans, :duration, :integer
    add_column :plans, :period, :integer
  end
end
