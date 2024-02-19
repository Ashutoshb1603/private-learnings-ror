class CreateEliteEligibilities < ActiveRecord::Migration[6.0]
  def change
    create_table :elite_eligibilities do |t|
      t.integer :interval, :default => 1
      t.integer :time
      t.integer :eligibility_on, :default => 1
      t.string :product_type
      t.integer :value
      t.integer :frequency, :default => 1

      t.timestamps
    end
  end
end
