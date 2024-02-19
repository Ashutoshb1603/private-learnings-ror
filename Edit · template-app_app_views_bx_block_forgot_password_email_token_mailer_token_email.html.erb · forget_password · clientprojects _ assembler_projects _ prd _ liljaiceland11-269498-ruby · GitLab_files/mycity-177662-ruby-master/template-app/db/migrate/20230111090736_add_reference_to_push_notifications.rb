class AddReferenceToPushNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :push_notifications, :admin_user
    add_column :push_notifications, :content, :string
  end
end
