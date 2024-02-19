module BxBlockChat
  class FlaggedMessagesController < BxBlockChat::ApplicationController
		rescue_from ActiveRecord::RecordNotFound, :with => :not_found
    before_action :find_flagged_msg, only: [:create, :unflag_message]

    def create
      begin
        if !@flagged_message.present?
          @flagged_message = BxBlockChat::FlaggedMessage.create!(flagged_message_params)
        end
        @flagged_message.flagged_message_accounts.create!(account_id: params[:account_id])
        render json: {message: "Message marked as flagged"}, status: :created
      rescue Exception => e
        render json: { errors: e.message },
          status: :unprocessable_entity
      end
    end

    def index
			@flagged_messages = BxBlockChat::FlaggedMessage.where(conversation_sid: params[:conversation_sid])
			render json: ::BxBlockChat::FlaggedMessageSerializer.new(@flagged_messages, serialization_options).serializable_hash, status: :ok if @flagged_messages
    end

    def unflag_message
      if @flagged_message.present?
        flag_account = @flagged_message.flagged_message_accounts.find_by(account_id: params[:account_id])
        if flag_account&.destroy
          @flagged_message.destroy if @flagged_message.flagged_message_accounts&.count == 0
          render json: { message: "Unflagged message" },
            status: :ok
        else
          render json: { errors: "Account not found" },
            status: :unprocessable_entity
        end
      end
    end

    private

    def flagged_message_params
      params.permit(:conversation_sid, :message_sid)
    end

    def find_flagged_msg
      @flagged_message = BxBlockChat::FlaggedMessage.find_by(conversation_sid: params[:conversation_sid], message_sid: params[:message_sid])
    end
  end
end
