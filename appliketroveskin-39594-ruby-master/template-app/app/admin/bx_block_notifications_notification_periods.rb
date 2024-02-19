ActiveAdmin.register BxBlockNotifications::NotificationPeriod, as: 'Notification Period' do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :notification_type, :period_type, :period
  menu label: "Notifications Flows"
  #
  # or
  #
  # permit_params do
  #   permitted = [:notification_type, :period_type, :period]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  remove_filter :created_at, :updated_at
  
  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Notification Periods', admin_notification_periods_path)
  #   end
  #   links
  # end
  
  form do |f|
    inputs do
      f.input :notification_type, as: :select, collection: BxBlockNotifications::NotificationPeriod.notification_types, include_blank: 'Select notification type'
      f.input :period_type, as: :radio, collection: BxBlockNotifications::NotificationPeriod.period_types
      f.input :period
    end
    f.actions
  end

  index do
    selectable_column
    column :notification_type
    column :period_type
    column :period
    actions
  end

  csv do
    column :notification_type
    column :period_type
    column :period
  end
end
