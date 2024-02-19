class RemoveReferencesColumn < ActiveRecord::Migration[6.0]
  def change
    if AccountBlock::Device.column_names.include?('admin_user_id')
      remove_reference :devices, :admin_user
    end
    if BxBlockPushNotifications::PushNotification.column_names.include?('admin_user_id')
      remove_reference :push_notifications, :admin_user
    end
  end
end
