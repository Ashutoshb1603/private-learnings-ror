module BxBlockChat
    class ChatController < ApplicationController
        before_action :get_user
        before_action :get_user_chats
        before_action :is_freezed
        @@twilio = BxBlockLivestreaming::TwilioController.new

        def index
            chats = @chats.active.order(pinned: :desc)
            render json: ChatSerializer.new(chats, params: {current_user: @account}).serializable_hash
        end


        def create_chat
            @customer = AccountBlock::Account.find_by(id: params[:user_id])
            if @customer.nil?
                message = "Customer is not registered with us."
                status = 404
            else
                chats = @account.customer_chats.find_or_create_by(account_id: @customer.id)
                chats.status = 'active' if chats.status == 'inactive'
                chats.end_date = ''
                chats.save!
                message = "Customer is registered with us."

            end

            render json: {message: message , chat_id: chats&.id}, status: status
        end

        def show
            chat = @chats.find(params[:id])
            if chat.end_date.present? && chat.end_date <= Time.now
                chat.update(status: 'inactive')
                render json: {errors: ['This session has ended.']}, status: 422
            else
                sid = chat.sid
                conversation_sid = @@twilio.conversation_sid("CHAT#{chat.id}") if sid.nil?
                sid = conversation_sid[:sid] if conversation_sid.present?
                begin
                    participant_sid = @@twilio.participant_sid(sid, @account)
                rescue Twilio::REST::RestError => e
                    conversation_sid = @@twilio.conversation_sid("CHAT#{chat.id}")
                    sid = conversation_sid[:sid]
                    participant_sid = @@twilio.participant_sid(sid, @account)
                end
                chat_service_sid = conversation_sid[:chat_service_sid] if conversation_sid.present?
                chat_service_sid = @@twilio.conversation_service_sid(sid) unless chat_service_sid.present?
                chat_token = @@twilio.get_chat_token(chat_service_sid, @account)
                chat.update(sid: sid)
                chat.messages.where.not(account: @account, is_read: true).update(is_read: true)
                render json: MessageSerializer.new(chat, params: {current_user: @account}, meta: {sid: sid, chat_service_sid: chat_service_sid, chat_token: chat_token, participant_sid: participant_sid}).serializable_hash
            end
        end

        def disable_chats
            chats = @chats.where(id: params[:data][:ids])
            chats.update(status: 'inactive')
            render json: {message: "Chats disabled successfully"}
        end

        def pin_or_unpin
            chats = @chats.where(id: params[:data][:ids])
            chats.each do |chat|
                pin = chat.pinned
                chat.update(pinned: !pin)
            end
            render json: {message: "Chat pinned/unpinned successfully"}
        end

        def send_message
            chat = @chats.find(params[:id])
            message = @account.messages.create(chat_id: chat.id)
            # message = chat.messages.create(account_id: @account.id)
            message.update(chat_params)
            receiver = chat.therapist if chat.account == @account
            receiver = chat.account if chat.therapist == @account
            payload_data = {account: receiver, notification_key: 'chat_message', inapp: true, push_notification: true, redirect: 'chat', type: 'admin', record_id: chat.id, notification_for: 'chat', key: 'skin_journey'}
            BxBlockPushNotifications::FcmSendNotification.new("#{@account&.first_name&.humanize} wants to reach out to  you  - view here!", "New Message", receiver.device_token, payload_data).call
            render json: MessageSerializer.new(chat, params: {current_user: @account}).serializable_hash
        end

        def mark_unread
            chats = @chats.where(id: params[:data][:ids])
            chats.each do |chat|
                messages = chat.messages
                id = messages.order('created_at DESC').where(account_id: @account.id)&.first&.id
                id = messages.order('created_at DESC').last.id.to_i - 1 if id.nil?
                last_message_id = messages.order('created_at DESC').first.id
                if last_message_id.present?
                    ids = [*id+1..last_message_id]
                    messages.where(id: ids).update(is_read: false)
                end
            end
            render json: {message: "Messages marked as unread"}
        end

        private
        def chat_params
            params["data"].permit(:message, :image, message_objects_attributes: [:id, :title, :object_id, :object_type, :price, :variant_id, :image_url])
        end

        def get_user
            @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
            @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
            render json: {errors: ['Account not found']}  unless @account.present?
        end

        def get_user_chats
            @user_type = @account.role.name.downcase
            @chats = (@user_type == "therapist" || @user_type == "admin") ? @account.customer_chats : @account.chats
        end
    end
end
