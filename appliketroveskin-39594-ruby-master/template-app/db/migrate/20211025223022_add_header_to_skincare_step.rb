class AddHeaderToSkincareStep < ActiveRecord::Migration[6.0]
  def change
    add_column :skincare_steps, :header, :string
  end
end
