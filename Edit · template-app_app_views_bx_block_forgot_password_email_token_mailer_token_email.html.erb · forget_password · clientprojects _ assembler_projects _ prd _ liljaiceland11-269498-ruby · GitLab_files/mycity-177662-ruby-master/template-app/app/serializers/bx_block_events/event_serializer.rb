module BxBlockEvents
  class EventSerializer < BuilderBase::BaseSerializer

    attributes *[
      :title,
      :time,
      :latitude,
      :longitude,
      :email_account_id,
      :notify,
      :repeat,
      :custom_repeat_in_number,
      :custom_repeat_every,
      :notes,
      :assignee_email,
      :visible_email,
      :created_at,
      :updated_at,
      :event_type,
      :address
    ]

    attribute :date do |object, params|
      begin
        date = params[:current_date]
        date.present? ? date.to_date : object.date
      rescue Exception => e
        object.date
      end
    end

    attribute :color_code do |object, params|
      code = ''
      account = params[:account]
      if account
        if object.owner?(account) || object.assign_and_accepted?(account)
          code = '#6bff65'
        elsif object.assign_and_rejected?(account)
          code = '#ff6161'
        elsif object.visibility_to(account) || object.assign_and_pending?(account)
          code = '#fdce58'
        else
          code = '#fdce58'
        end
      end
      code
    end

    attribute :role do |object, params|
      role = ''
      account = params[:account]
      if account
        role = 'Owner' if object.owner?(account)
        role = 'Visibile User' if object.visibility_to(account)
        role = 'Assigned User' if object.assign_to?(account)
      end
      role
    end

    attribute :assigned_to do |object|
      object&.assignment_to&.map{|u| u.as_json(only: [:id, :first_name, :last_name])}
    end

    attribute :visibility do |object|
      object&.visible_to&.map{|u| u.as_json(only: [:id, :first_name, :last_name])}
    end

    attribute :user do |object|
      AccountBlock::EmailAccountSerializer.new(object.email_account)
    end
  end
end
