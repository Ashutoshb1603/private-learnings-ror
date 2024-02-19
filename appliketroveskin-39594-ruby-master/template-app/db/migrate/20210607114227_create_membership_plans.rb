class CreateMembershipPlans < ActiveRecord::Migration[6.0]
  def change
    create_table :membership_plans do |t|
      t.integer :plan_type
      t.datetime :start_date, :default => Time.now
      t.datetime :end_date, :default => Time.now
      t.integer :time_period
      t.integer :account_id

      t.timestamps
    end
  end
end
