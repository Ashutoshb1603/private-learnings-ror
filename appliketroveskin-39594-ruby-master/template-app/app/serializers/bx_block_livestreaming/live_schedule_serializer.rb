module BxBlockLivestreaming
    class LiveScheduleSerializer < BuilderBase::BaseSerializer
      attributes *[
        :at,
        :guest_email,
        :user_type,
        :event_creation_notification,
        :reminder_notification,
        :status
      ]

    end
  end
  