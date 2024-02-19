class AddImageInNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :push_notifications, :image, :string
  end
end
