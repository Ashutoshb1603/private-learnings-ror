ActiveAdmin.register BxBlockNotifications::Notification, as: "Notifications" do
  menu false
  actions :all, :except => [:new, :destroy, :edit]
  scope("All") { |scope| scope.where(account_id: nil) }
  scope("Unread") { |scope| scope.where(account_id: nil, is_read: [false, nil]) }
  scope("Read") { |scope| scope.where(account_id: nil, is_read: true) }
  scope :admin_notifications, default: true

  collection_action :mark_read, method: :put do
  end

  collection_action :mark_all_read, method: :get do
    BxBlockNotifications::Notification.where(account_id: nil, is_read: [nil, false]).update_all(is_read: true)
    redirect_to admin_notifications_path, notice: 'Updated Successfully'
  end

  action_item :mark_all_read do
    link_to 'Mark All Read', mark_all_read_admin_notifications_path
  end

  index do
    id_column
    column :headings
    column :contents
    column :app_url
    column :is_read
    column :read_at
    column :created_at
    column :updated_at
    actions defaults: true do |_notification|
      if !_notification&.is_read?
        link_to 'Mark Read', mark_read_admin_notifications_path(id: _notification.id), method: :put
      end
    end
  end

  show do
    attributes_table do
      row :headings
      row :contents
      row :app_url
      row :is_read
      row :read_at
      row :created_at
      row :updated_at
    end
  end

  controller do
    def show
      resource.update(is_read: true)
    end

    def mark_read
      resource.update(is_read: true)
      redirect_to admin_notifications_path, notice: 'Updated Successfully'
    end
  end

end
