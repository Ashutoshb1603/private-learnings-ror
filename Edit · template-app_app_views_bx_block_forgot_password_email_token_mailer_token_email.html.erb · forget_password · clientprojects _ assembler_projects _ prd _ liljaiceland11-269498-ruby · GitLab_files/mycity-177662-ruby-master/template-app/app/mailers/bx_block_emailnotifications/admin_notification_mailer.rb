module BxBlockEmailnotifications
  class AdminNotificationMailer < ApplicationMailer
    
    def activity_change(activity_name, user_email)
      @activity_name = activity_name
      mail(
        to: user_email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Modified your activity by admin'
      )
    end

    def interest_change(name, user_email)
      @interest_name = name
      mail(
        to: user_email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Modified your interest by admin'
      )
    end

    def travel_item_change(name, user_email)
      @travel_item_name = name
      mail(
        to: user_email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Modified Travel Item by admin'
      )
    end

    def weather_change(name, user_email)
      @weather_name = name
      mail(
        to: user_email,
        from: 'builder.bx_dev@engineer.ai',
        subject: 'Modified Weather by admin'
      )
    end

    def social_club_joined(name, user_email, club_user)
      @social_club = name
      @club_user = "#{club_user.account&.first_name&.capitalize} #{club_user.account&.last_name&.capitalize}"
      mail(
        to: user_email,
        from: 'builder.bx_dev@engineer.ai',
        subject: "New member joined #{name}" 
      )
    end

    def club_event_registration(name, user_email, club_event_account)
      @club_event = name
      @club_event_account = "#{club_event_account.account&.first_name&.capitalize} #{club_event_account.account&.last_name&.capitalize}"
      mail(
        to: user_email,
        from: 'builder.bx_dev@engineer.ai',
        subject: "New member joined #{name}" 
      )
    end

    def interest_based_club_created(name, user_emails)
      @social_club = name
      mail(
        to: user_emails,
        from: 'builder.bx_dev@engineer.ai',
        subject: "New Social Club: #{name} created" 
      )
    end
  end
end
