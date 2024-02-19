module BxBlockNotifications
  class NotificationPeriodSerializer
    include JSONAPI::Serializer
    attributes :id, :notification_type, :period_type, :period, :created_at, :updated_at
  end
end