module BxBlockEvent
  class EventsController < ApplicationController
    before_action :current_user, only: [:create, :index, :delete_event]

    def create
      event = @current_user.user_event.present? ? @current_user.user_event : @current_user.create_user_event
      
      save_result = event.update(event_params.merge(show_frame_till: nil))

      if event.present?
        render json: EventSerializer.new(event).serializable_hash,
               status: :created
      else
        render json: {errors: {message: event.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def delete_event
      event = @current_user.user_event
      event.destroy
      render json: {message: 'Event deleted successfully'}
    end

    def index
      events = @current_user.user_event
      serializer = EventSerializer.new(events)
      render json: serializer, status: :ok
    end

    def life_events
      events = LifeEvent.all
      life_event_info = AccountBlock::InfoText.find_by_screen('life_event')&.description || ""
      serializer = LifeEventSerializer.new(events, meta: {info_text: life_event_info})
      render json: serializer, status: :ok
    end

    private

    def event_params
      params.require(:user_event).permit(:event_date, :life_event_id, :account_id)
    end
  end
end