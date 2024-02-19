class AddOperatorToAircrafts < ActiveRecord::Migration[6.0]
  def change
    add_column :aircrafts, :operator_id, :bigint
  end
end
