module BxBlockLivestreaming
    class TwilioController < ApplicationController
        @@account_sid = ENV['TWILIO_SID']
        @@api_key = ENV['TWILIO_API_KEY']
        @@api_secret = ENV['TWILIO_API_SECRET']
        @@auth_key = ENV['TWILIO_AUTH_KEY']
        @@auth_token = ENV['TWILIO_AUTH_TOKEN']

        include ApiHelper
        require 'twilio-ruby'
        @@notification = BxBlockNotifications::NotificationsController.new

        before_action :validate_json_web_token
        before_action :get_user 
        before_action :validate_admin, only: [:create, :end_video_chat]

        def create
            room_name = @account.first_name.to_s + "_" + Time.now.to_i.to_s
            endpoint = "v1/Rooms/#{room_name}"
            room = get_response(endpoint)
            if JSON.parse(room)["status"] == 404
                body = "UniqueName=#{room_name}&RecordParticipantsOnConnect=True&Type=group"
                endpoint = "v1/Rooms"
                room = get_response(endpoint, body, "post")
            end
            token = get_token(room_name)
            # sid = service_sid(room_name)
            conversation_sid = conversation_sid(room_name)
            participant_sid = participant_sid(conversation_sid[:sid], @account)
            chat_token = get_chat_token(conversation_sid[:chat_service_sid], @account)
            room = JSON.parse(room)

            if params[:live_schedule_id].present?
                live_schedule = LiveSchedule.find(params[:live_schedule_id])
                user_type = live_schedule.user_type
                guest_email = live_schedule.guest_email || ""
                live_schedule.update(status: 'live', room_name: room_name)
                @@notification.user_notifications(room_name, user_type, "live_streaming", "Skin Deep", "Skin Deep is live - tap to join!", guest_email, conversation_sid[:sid])
            else
                user_type = params[:user_type] || "all"
                guest_email = params[:guest_email] || ""
                @@notification.user_notifications(room_name, user_type, "live_streaming", "Skin Deep", "Skin Deep is live - tap to join!", guest_email, conversation_sid[:sid])
            end

            # account = AccountBlock::Account.find_by(email: params[:email])
            # payload_data = {account: @account, notification_key: 'video_streaming_started', inapp: true, push_notification: true, key: 'live'}
            # BxBlockPushNotifications::FcmSendNotification.new("A live stream has been scheduled for #{DateTime.now}", "Live streaming scheduled", @account.device_token, payload_data).call
            # BxBlockPushNotifications::FcmSendNotification.new("Skin Deep are live - tap to join!", "Live streaming scheduled", @account.device_token, payload_data).call
            # @@notification.user_notifications(room_name, user_type, "live_streaming", "Skin Deep", "Skin Deep is live - tap to join!", guest_email, conversation_sid[:sid])
            render json: {room: room, token: token, sid: conversation_sid[:sid], chat_service_sid: conversation_sid[:chat_service_sid], participant_sid: participant_sid, chat_token: chat_token, owner_id: @account.id}
        end

        def show
            room_name = params[:id]
            sid = params[:sid]
            chat_service_sid = conversation_service_sid(sid)
            endpoint = "v1/Rooms/#{room_name}"
            room = get_response(endpoint)
            room = JSON.parse(room)
            token = ""
            message = ""
            chat_token = ""
            message = "Live stream has ended" if room["status"] == 404
            token = get_token(room_name) if room["status"] != 404
            chat_token = get_chat_token(chat_service_sid, @account) if room["status"] != 404
            participant_sid = participant_sid(sid, @account) if room["status"] != 404
            status = 200
            status = 404 if room["status"] == 404
            render json: {room: room, token: token, sid: sid, chat_service_sid: chat_service_sid, participant_sid: participant_sid, chat_token: chat_token, message: message}, status: status
        end

        def end_video_chat
            room_name = params[:room_name]
            @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
            room = @client.video.rooms(room_name).update(status: 'completed')
            # payload_data = {account: @account, notification_key: 'video_streaming_ended', inapp: true, push_notification: true}
            # BxBlockPushNotifications::FcmSendNotification.new("Skin Deep was live - view here!", "Live streaming ended", @account.device_token, payload_data).call

            live_video = create_composition(room.sid)
            create_composed_media(live_video) if live_video&.composition_sid.present?
            
            live_schedule = LiveSchedule.find_by(room_name: room_name)
            live_schedule.update(status: 'completed') if live_schedule.present?
            
            # @client.chat.services(params[:sid]).delete if params[:sid].present?
            render json: {message: "room completed", room_status: room.status, room: room.unique_name}
        end

        def service_sid(room_name)
            @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
            service = @client.chat.services.create(friendly_name: room_name)
            service.sid
        end

        def get_token(room_name)
            identity = @account.name.to_s

            video_grant = Twilio::JWT::AccessToken::VideoGrant.new
            video_grant.room = room_name

            token = Twilio::JWT::AccessToken.new(
                @@account_sid,
                @@api_key,
                @@api_secret,
                [video_grant],
                identity: identity
            )

            # Generate the token
            token.to_jwt   
        end

        def get_chat_token(sid, account)
            identity = account&.email

            grant = Twilio::JWT::AccessToken::ChatGrant.new
            grant.service_sid = sid
            # Create an Access Token
            token = Twilio::JWT::AccessToken.new(
                @@account_sid,
                @@api_key,
                @@api_secret,
                [grant],
                identity: identity
            )
            
            # Generate the token
            token.to_jwt
        end

        def conversation_sid(room_name)
            @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
            conversation = @client.conversations.conversations.create(friendly_name: room_name)
            {sid: conversation.sid, chat_service_sid: conversation.chat_service_sid}
        end

        def participant_sid(sid, account)
            @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
            # participant = @client.conversations
            #          .conversations(sid)
            #          .participants
            #          .create(identity: account&.email)

            # participant.sid
            begin
                participant = @client.conversations.conversations(sid).participants.create(identity: account&.email)
            rescue Twilio::REST::RestError => e
                # participants = @client.conversations.conversations(sid).participants.list

                # participants.each do |record|
                #     @client.conversations.conversations(sid).participants(record.sid).delete if record.identity == account&.email
                # end

                # participant = @client.conversations.conversations(sid).participants.create(identity: account&.email)
                participant = nil
            end
            participant&.sid
        end

        def conversation_service_sid(sid)
            @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
            conversation = @client.conversations
                      .conversations(sid)
                      .fetch
            conversation.chat_service_sid
        end

        def create_composition(room_sid)
            @composition_client = Twilio::REST::Client.new(@@api_key, @@api_secret)
            container_format = 'mp4'
            composition = @composition_client.video.compositions.create(
                room_sid: room_sid,
                audio_sources: '*',
                video_layout: {
                    grid: {
                    video_sources: ['*']
                    }
                },
                status_callback: 'http://my.server.org/callbacks',
                format: container_format
            )

            composition_sid = composition.sid
            live_video = BxBlockContentmanagement::LiveVideo.find_or_create_by(room_sid: room_sid)
            live_video.update(title: "Processing", composition_sid: composition_sid, status: 'processing')
            live_video
        end

        def create_composed_media(live_video)
            @composition_client = Twilio::REST::Client.new(@@api_key, @@api_secret)
            container_format = "mp4"
            uri = "https://video.twilio.com/v1/Compositions/#{live_video.composition_sid}/Media?Ttl=3600"
            response = @composition_client.request("video.twilio.com", 433, 'GET', uri)
            media_location = response.body['redirect_to']
            if media_location.present?
                filename = Time.now.to_i
                media_content = Net::HTTP.get(URI(media_location))
                # open("#{Rails.root}/public/#{filename}.#{container_format}", "wb") do |file|
                #     file << open(media_location).read
                # end
                File.open("#{Rails.root}/public/#{filename}.#{container_format}", 'wb') do |f| 
                    f.write(media_content) 
                end
                live_video.videos.attach(filename: "#{filename}.#{container_format}", io: File.open("#{Rails.root}/public/#{filename}.#{container_format}"))
                live_video.update(title: "", status: 'inactive')
                FileUtils.rm("#{Rails.root}/public/#{filename}.#{container_format}")
                delete_recordings(live_video.room_sid)
                @composition_client.video.compositions(live_video.composition_sid).delete()
            end
        end

        private

        def delete_recordings(room_sid)
            @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
            recordings = @client.video.recordings.list(grouping_sid: [room_sid])
            while !recordings.empty?
                recordings.each do |rec| 
                    @client.video.recordings(rec.sid).delete
                end
                recordings = @client.video.recordings.list(grouping_sid: [room_sid])
            end
        end

        def get_response(endpoint, body="", type="get")
            url = "https://video.twilio.com/" + endpoint
            request = Hash.new
            request["Content-Type"] = "application/x-www-form-urlencoded" if type == "post"
            request["Authorization"] = @@auth_key
            ApiReader.new.call(url, request, body, type).read_body
        end

        def get_user
           @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
           @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
           @account
        end

        def validate_admin
            errors = []
            errors = ['Account is not associated to an admin'] unless @account.type == "AdminAccount"
            render json: {errors: errors} unless errors.empty?
        end

    end
end
