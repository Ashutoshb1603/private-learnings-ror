ActiveAdmin.register BxBlockNotifications::Notification, as: "Notification" do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :created_by, :headings, :contents, :app_url, :is_read, :read_at , account_ids: []
  actions :all, except: [:edit]
  menu label: 'In App Notifications'
  #
  # or
  #
  # permit_params do
  #   permitted = [:created_by, :headings, :contents, :app_url, :is_read, :read_at, :account_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  collection_action :update_crontab, method: :get do
    system "whenever --update-crontab"
    redirect_to admin_notifications_path
  end


  remove_filter :created_at, :updated_at, :app_url
  
  # breadcrumb do
  #   links = [link_to('Admin', admin_root_path)]
  #   if %(new create).include?(params['action'])
  #     links << link_to('Notifications', admin_notifications_path)
  #   end
  #   links
  # end

  csv do
    column :headings
    column :contents
    column :is_read
    column :read_at
    column "User" do |notification|
      notification.accountable.name
    end
  end

  index do
    selectable_column
    column :headings
    column :contents
    column :is_read
    column :read_at
    column :user do |notification|
      notification.accountable.name
    end
    actions
  end

  show do |notification|
    attributes_table do
      row :headings
      row :contents
      row :is_read
      row :read_at
      row :user do
        notification.accountable.name
      end
      row :created_at
      row :updated_at
    end
  end

  form partial: 'form'

  controller do
    def create
      if params[:user_type] != "select_customers" || params[:account_ids].present?
        notifications = []

        accounts = AccountBlock::Account.all if params[:user_type] == "all"
        accounts = AccountBlock::Account.active.reject {|account| account.membership_plan[:plan_type] != "elite"} if params[:user_type] == "elite"
        accounts = AccountBlock::Account.active.reject {|account| account.membership_plan[:plan_type] != "glow_getter"} if params[:user_type] == "glow_getter"
        accounts = AccountBlock::Account.active.reject {|account| account.membership_plan[:plan_type] != "free" || account&.role&.name.downcase != "user"} if params[:user_type] == "free"
        accounts = AccountBlock::Account.active.reject {|account| account&.role&.name.downcase != "therapist"} if params[:user_type] == "therapists"
        accounts = AccountBlock::Account.where(id: params[:account_ids]) if params[:account_ids].present?

        accounts.each do |account|
          notification = account.notifications.find_or_create_by(permitted_params[:notification])
          notification.persisted? ? notifications << notification : @errors = notification.errors.full_messages.join(", ")
        end
        if notifications.present?
          # Sending Push notifications
          fcm = FCM.new(ENV["FIREBASE_SERVER_KEY"])
          registration_ids = accounts.map(&:device_token)
          options = { "notification":
                     {
                        "title": "#{permitted_params[:notification][:headings]}",
                        "body": "#{permitted_params[:notification][:contents]}"
                     }
                    }
          response = fcm.send(registration_ids, options)

          flash[:notice] = "Notifications was successfully created."
          redirect_to admin_notifications_path
        else
          send_error_response(permitted_params[:notification], @errors)
        end
      else
        send_error_response(permitted_params[:notification])
      end
    end

    private

    def send_error_response(notification_params, errors = false)
      notification = BxBlockNotifications::Notification.new(notification_params)
      notification.save
      @resource = notification
      flash.now[:error] = errors.present? ? errors : notification.errors.full_messages.join(", ")
      render :new
    end
  end
end
