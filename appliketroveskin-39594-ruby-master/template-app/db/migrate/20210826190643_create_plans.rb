class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.integer :price_cents
      t.string :name
      t.string :stripe_plan_name

      t.timestamps
    end
  end
end
