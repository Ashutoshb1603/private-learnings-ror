module BxBlockEventregistration
    class AccountEventBlocksController < BxBlockEventregistration::ApplicationController
        def create
            @event = BxBlockEventregistration::EventBlock.find(params[:event_id])
            @event_user = current_user.account_event_blocks.new(event_block_id: params[:event_id])
            if @event_user.save
                render json: BxBlockEventregistration::AccountEventBlockSerializer.new(@event_user,
                            meta: {message: "Thank you for registering in #{@event.event_name} event"})
                            .serializable_hash, status: :created
            else
                render json: {errors: @event_user.errors.full_messages },
                    status: :unprocessable_entity
            end
        end
    end
end
