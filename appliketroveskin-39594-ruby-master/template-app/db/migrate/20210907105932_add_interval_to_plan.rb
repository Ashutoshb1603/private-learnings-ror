class AddIntervalToPlan < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :interval, :string
  end
end
