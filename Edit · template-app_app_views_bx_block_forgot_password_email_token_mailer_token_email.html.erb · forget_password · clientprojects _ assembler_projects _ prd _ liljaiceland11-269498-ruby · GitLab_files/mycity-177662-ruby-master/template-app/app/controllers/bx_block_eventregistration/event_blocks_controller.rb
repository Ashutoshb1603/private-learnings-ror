module BxBlockEventregistration
    class EventBlocksController < BxBlockEventregistration::ApplicationController
        def index
            @events = BxBlockEventregistration::EventBlock.all
            render json: BxBlockEventregistration::EventBlockSerializer.new(@events).serializable_hash, status: :ok
        end

        def create
            @event = BxBlockEventregistration::EventBlock.new(event_block_params)
            if @event.save
                render json: BxBlockEventregistration::EventBlockSerializer.new(@event).serializable_hash, status: :created
            else
                render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
            end	  	
        end

        def show
            @event = BxBlockEventregistration::EventBlock.find_by(id: params[:id])
            if @event.present?
                render json: BxBlockEventregistration::EventBlockSerializer.new(@event).serializable_hash, status: :ok 
            else
                render json: {messages: "Record not found"}, status: :not_found
            end           
        end
       
        private
    
        def event_block_params
          params.require(:data)[:attributes].permit(:event_name, :location, :start_date_and_time, 
                                                    :end_date_and_time, :start_time, :end_time,
                                                    :description, images: [])
        end
    end
end