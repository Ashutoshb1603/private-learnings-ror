module BxBlockNotifications
    class AppointmentNotificationWorker
      include Sidekiq::Worker
      FIREBASE_API_KEY = ENV["FIREBASE_SERVER_KEY"]
      
      def perform()
        appointment_reminder
        # appointment_follow_up_3_weeks
        appointment_follow_up
        book_a_consultation
      end

      def appointment_reminder
        date = Date.tomorrow
        accounts = AccountBlock::Account.joins(:appointments).where('appointments.date >= ? and appointments.date <= ?', date.beginning_of_day, date.end_of_day).distinct
        
        accounts.each do |account|
            appointment = account.appointments.where(date: date.all_day).first
            if appointment.present?
                BxBlockAppointmentManagement::AppointmentMailer.with(account: account, appointment: appointment).appointment_reminder.deliver_now
                payload_data = {account: account, notification_key: 'skin_journey_two', inapp: true, push_notification: true, all: false, type: 'appointment', notification_for: 'appointment', key: 'appointment'}
                BxBlockPushNotifications::FcmSendNotification.new("Your skin consultation reminder - #{appointment.date.strftime("%d %B %Y")} #{appointment.time}", "Your skin consultation reminder", account&.device_token, payload_data).call
            end
        end
      end

      def appointment_follow_up
        date = 8.weeks.ago
        accounts = AccountBlock::Account.joins(:appointments).where('appointments.date >= ? and appointments.date <= ?', date.beginning_of_day, date.end_of_day).distinct
        
        accounts.each do |account|
            appointment = account.appointments.where(date: date.all_day).first
            if appointment.present?
                BxBlockAppointmentManagement::AppointmentMailer.with(account: account).appointment_follow_up.deliver_now
                payload_data = {account: account, notification_key: 'ConsultationTypeSelection', inapp: true, push_notification: true, all: false, type: 'appointment', notification_for: 'appointment', key: 'appointment'}
                BxBlockPushNotifications::FcmSendNotification.new("You are now 8-weeks into your skin journey. We are eager to see how you are progressing and if you are ready to accelerate your results. Book your follow up appointment today.", "Let's progress", account&.device_token, payload_data).call
            end
        end
      end

      def appointment_follow_up_3_weeks
        date = 3.weeks.ago
        accounts = AccountBlock::Account.joins(:appointments).where('appointments.date >= ? and appointments.date <= ?', date.beginning_of_day, date.end_of_day).distinct
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'ConsultationTypeSelection', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'book_consultation', key: 'appointment'}
        BxBlockPushNotifications::FcmSendNotification.new("Let's assess your progress and accelerate your results. Book a follow up call today ? ", "Book a follow up call today.", registration_ids, payload_data).call
      end

      def book_a_consultation
        accounts = AccountBlock::Account.joins(:membership_plans).where('end_date >= ? and membership_plans.created_at::date= ?', Time.now, 7.days.ago).distinct
        registration_ids = accounts.map(&:device_token)
        payload_data = {account_ids: accounts.map(&:id), notification_key: 'skin_log', inapp: true, push_notification: true, all: true, type: 'skin_hub', notification_for: 'book_consultation', key: 'appointment'}
        BxBlockPushNotifications::FcmSendNotification.new("Fast-Track your journey to healthy skin. Reach out to a skin expert today.", "Reach out to a skin expert today.", registration_ids, payload_data).call
      end
    end
  end