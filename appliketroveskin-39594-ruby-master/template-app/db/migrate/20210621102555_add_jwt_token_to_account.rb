class AddJwtTokenToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :jwt_token, :string
  end
end
