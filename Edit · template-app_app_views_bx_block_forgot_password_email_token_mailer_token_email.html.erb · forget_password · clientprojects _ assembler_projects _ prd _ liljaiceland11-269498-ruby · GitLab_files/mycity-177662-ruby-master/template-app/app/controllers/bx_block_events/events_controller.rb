module BxBlockEvents
  class EventsController < ApplicationController
    before_action :set_account
    before_action :set_event, only: [:show, :update, :destroy, :notes_update]

    def index
      final_events = []
      assigned_events = Event.all.select{|x| (x.assign_to.include?(@account.id.to_s) && x.visibility.include?(@account.id.to_s))}
      account_events = @account.events.to_a
      final_events = assigned_events + account_events
      final_events = final_events.uniq.group_by { |t| t[:event_type] }
      render json: {data: final_events, each_serializer: EventSerializer }
    end

    def create
      @event = Event.new(events_params)
      @event.email_account_id = @account.id
      @event.time = params[:data][:attributes][:time].to_time.utc if params[:data][:attributes][:time].present?
      @event.repeat = "Never" if @event.repeat == nil
      @event.notify = "15 Minutes Before" if @event.notify == nil
      if @event.save
        title = "#{@event.title&.strip} has been created."
        assign_event_notification_create(title)
        vissible_event_notification_create(title)
        render json: EventSerializer.new(@event).serializable_hash, status: :created
      else
        render json: {errors: [format_activerecord_errors(@event.errors)]}, status: 422
      end
    end

    def show
      render json: EventSerializer.new(@event, params: {account: @account, current_account: @account}).serializable_hash, status: 200
    end

    def update
      return render json: {errors: [{account: 'You are not authorize to update event'} ]}, status: :unprocessable_entity unless @event.owner?(@account)
      event_params = events_params
      event_params["time"] = event_params["time"].to_time.utc if event_params["time"].present?
      if event_params["date"].present?
        new_event_date = event_params["date"].to_date
        event_params["date"] = @event.event_occurance.occurs_on?(new_event_date) ? @event.date : new_event_date
      end
      if @event.update(event_params)
        title = "#{@event.title&.strip} has been updated."
        body = "#{@event.title&.strip} event created on #{@event.created_at.strftime('%d-%m-%Y')} by #{@account.first_name&.strip || @account.email} is updated"
        BxBlockPushnotifications::Notification.new.create_notification(@event, {account: @account, body: body, title: title }) rescue nil
        render json: EventSerializer.new(@event, params: {account: @account, current_account: @account}).serializable_hash, status: 200
      else
        render json: {errors: [format_activerecord_errors(@event.errors)]}, status: 422
      end
    end

    def destroy
      if @event.present?
        @event.destroy
        render json: {message: "Successfully deleted the record"}
      else
        return render json: {errors: [
          {account: 'Event Not Found'},
        ]}, status: :unprocessable_entity
      end
    end

    def overlap_event
      event_data = Event.find_or_initialize_by(events_params)
      events = BxBlockEvents::Event.account_events(@account.id)
      if params[:data][:event_id].present?
        event = Event.find(params[:data][:event_id])
        events = events.reject{|e| e == event}
      end
      event_data.time = params[:data][:attributes][:time].to_time.utc if params[:data][:attributes][:time].present?
      schedule_events = events.select{|event| (event.event_occurance.occurs_on?(event_data.date.to_date)) && (event.time.strftime("%H:%M") == event_data.time.strftime("%H:%M"))}
      schedule_events.count.zero? ? (render json: {message: "No event overlap"}) : (render json: {message: "Event overlap"})
    end

    def notes_update
      return render json: {errors: [{account: 'You are not authorize to update event'} ]}, status: :unprocessable_entity unless @event.owner?(@account) || @event.assign_and_accepted?(@account)
      if @event.update(notes: params[:notes])
        title = "#{@event.title&.strip} has been updated."
        body = "The event's note #{@event.title&.strip} created on #{@event.created_at.strftime('%d-%m-%Y')} is updated by #{@account.first_name&.strip || @account.email}"
        BxBlockPushnotifications::Notification.new.create_notification(@event, {account: @account, body: body, title: title }) rescue nil
        render json: EventSerializer.new(@event, params: {account: @account, current_account: @account}).serializable_hash, status: 200
      else
        render json: {errors: [format_activerecord_errors(@event.errors)]}, status: 422
      end
    end

    private

    def events_params
      jsonapi_deserialize(params)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def assign_event_notification_create(title)
      if @event.assignment_to.any?
        entity_users = @event.assignment_to.to_a << @event.email_account
        entity_users.delete(@account)
        body = "#{@event.title&.strip} by #{@account&.first_name&.strip || @account.email} has been assigned to you."
        create_event_notification(title, body, entity_users)
      end
    end

    def vissible_event_notification_create(title)
      if @event.visible_to.any?
        entity_users = @event.visible_to.to_a << @event.email_account
        entity_users.delete(@account)
        body = "#{@event.title&.strip} by #{@account&.first_name&.strip || @account.email} has been made visible to you."
        create_event_notification(title, body, entity_users)
      end
    end

    def create_event_notification(title, body, entity_users)
      BxBlockPushnotifications::Notification.new.create_notification(@event, {account: @account, body: body, title: title, users: entity_users }) rescue nil
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def set_account
      @account = AccountBlock::EmailAccount.find(@token.id)
      return render json: {errors: ["Account not found."]} if @account.blank?
    end
  end
end
