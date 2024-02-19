class CreateUserImages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_images do |t|
      t.string :position
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
