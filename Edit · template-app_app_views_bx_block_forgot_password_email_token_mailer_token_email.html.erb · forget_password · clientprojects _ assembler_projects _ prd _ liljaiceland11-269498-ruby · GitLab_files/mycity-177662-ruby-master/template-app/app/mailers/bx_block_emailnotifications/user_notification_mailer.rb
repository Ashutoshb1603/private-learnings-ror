module BxBlockEmailnotifications
  class UserNotificationMailer < ApplicationMailer
    after_action { create_notification(@item, @name, @image, @notify_type) }
    
    def new_activity_added(activity_name)
      @name = activity_name
      @item = "Activity"
      @image = nil
      @notify_type='activity'
      mail(
        to: admin_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'New Activity added by user'
      )
    end

    def new_interest_added(interest_name, image)
      @name = interest_name
      @item = "Interest"
      @image = image
      @notify_type='interest'
      mail(
        to: admin_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'New interest added by user'
      )
    end

    def new_travel_item_added(travel_item_name)
      @name = travel_item_name
      @item = "Travel Item"
      @image = nil
      @notify_type='travel_item'
      mail(
        to: admin_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'New Travel Item added by user'
      )
    end

    def new_weather_added(name)
      @name = name
      @item = "Weather"
      @image = nil
      @notify_type='weather'
      mail(
        to: admin_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'New Weather added by user'
      )
    end

    def new_social_club(name, image)
      @name = name
      @item = "Social Club"
      @image = image
      @notify_type='social_club'
      mail(
        to: admin_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'New social club added by user'
      )
    end

    def new_club_event(club_event_name, image)
      @name = club_event_name
      @item = "Club Event"
      @image = image
      @notify_type='club_event'
      mail(
        to: admin_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'New club Event added by user'
      )
    end

    def new_hidden_place(name, image)
      @name = name
      @item = "Hidden Place"
      @image = image
      @notify_type='hidden_place'
      mail(
        to: admin_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'New Hidden Place added by user'
      )
    end

    private

    def create_notification(item, name, image, notify_type)
      # contents = "New #{item}: #{name} added by user"
      # headings = "New #{item} added"
      # BxBlockNotifications::Notification.create!(headings: headings, contents: contents, app_url: "", type: 0)
      # BxBlockPushNotifications::FcmSendNotification.new(account_emails: admin_emails, name: name, type: headings, title: contents).call rescue nil
      accounts = AdminUser.where(email: admin_emails)
			accounts.each do |account_object|
        BxBlockPushNotifications::PushNotification.create(
          push_notificable: account_object,
          remarks: "New #{item} added",
					content: "New #{item}: #{name} added by user",
          image: image,
          notify_type: notify_type
        )
      end
    end

    def admin_emails
      AdminUser.all.pluck(:email)
    end

  end
end
