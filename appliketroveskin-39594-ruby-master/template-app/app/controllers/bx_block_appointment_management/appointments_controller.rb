module BxBlockAppointmentManagement
  class AppointmentsController < ApplicationController
    @@acuity = AcuityController.new
    @@twilio = TwilioController.new
    @@account_sid = ENV['TWILIO_SID']
    @@api_key = ENV['TWILIO_API_KEY']
    @@api_secret = ENV['TWILIO_API_SECRET']
    @@auth_key = ENV['TWILIO_AUTH_KEY']
    @@auth_token = ENV['TWILIO_AUTH_TOKEN']
    @@notification = BxBlockNotifications::NotificationsController.new

    require 'twilio-ruby'

    before_action :get_user
    
    def types
        appointments = @@acuity.appointment_types
        currency = @account.location.downcase == "ireland" ? "EUR" : "GBP"
        addon_price = (currency == "EUR" ? ConsultationAddonPrice&.first&.addon_price : ConsultationAddonPrice&.first&.addon_price_in_pounds) || 0
        appointments.map {|appointment| (appointment["price"] = (appointment["price"].to_d + addon_price).to_s unless appointment["name"].downcase.include?("next"))} if @account.membership_plan[:plan_type] == "free"
        appointments.map {|appointment| 
            appointment["currency"] = currency
            appointment["price"] = (ConsultationPrice.find_by(consultation_id: appointment["id"].to_s)&.price.to_d + addon_price) if currency == "GBP" && !appointment["name"].downcase.include?("next")
            appointment["price"] = (ConsultationPrice.find_by(consultation_id: appointment["id"].to_s)&.price) if currency == "GBP" && appointment["name"].downcase.include?("next")
        }
        render json: {appointment_types: appointments}
    end

    def therapists
        therapists = @@acuity.therapists
        render json: {therapists: therapists}
    end

    def admin_list
        therapists = AccountBlock::Account.where.not(acuity_calendar: nil)
        admins = AdminUser.all
        response = []
        therapists.each do |therapist|
            list_hash = { id: therapist.id, name: therapist.name, email: therapist.email, location: therapist.location, type: "AccountBlock::Account" }
            response << list_hash
        end
        admins.each do |admin|
            list_hash = { id: admin.id, name: admin.name, email: admin.email, location: admin.location, type: "AdminUser" }
            response << list_hash
        end
        render json: {therapists: response }
    end

    def create
        user_account = @account.type == "AdminAccount" ? AccountBlock::Account.where('LOWER(email) = ?', appointment_params[:email].downcase).first : @account
        if user_account.present?
            consultation = user_account&.user_consultations.last
            dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic')
            image = get_image_url(dynamic_image) unless dynamic_image.nil?
            fields = [
                {
                    "id": 5784311,
                    "value": user_account&.name
                },
                {
                    "id": 5771115,
                    "value": user_account&.email
                },
                {
                    id: 5771113,
                    value: appointment_params[:age]
                },
                {
                    id: 5771114,
                    value: appointment_params[:phone]
                },
                {
                    id: 5771112,
                    value: appointment_params[:address]
                },
                {
                    id: 5784279,
                    value: image,
                },
                {
                    id: 5784280,
                    value: image,
                },
                {
                    id: 8048854,
                    value: image,
                },
                {
                    id: 5784281,
                    value: "yes",
                }
            ]
            consultation_form = BxBlockFacialtracking::SkinQuiz.where('question_type = ? and active=true', "consultation").left_joins(:account_choice_skin_logs).distinct(:skin_quiz_id)
            consultation_answers = consultation_form.map {|question| {id: question.acuity_field_id, value: (question.account_choice_skin_logs.find_by(account_id: user_account&.id)&.choices&.pluck(:choice)&.join(",") || question.account_choice_skin_logs.find_by(account_id: user_account&.id)&.other) || "test data"} if question.acuity_field_id.present?}
            fields = fields + consultation_answers.compact
            appointment = @@acuity.create(appointment_params.merge("fields": fields)) if ENV["TEST_ENV"] == "false"
            appointment = @@acuity.create(appointment_params) if ENV["TEST_ENV"] == "true"
            account = AccountBlock::Account.where('LOWER(email) = ?', appointment_params[:email].downcase).first
        end
        if appointment.present? and appointment["id"] != nil
            payload_data = {account: user_account, notification_key: 'skin_journey_two', inapp: true, push_notification: true, redirect: 'calendar', key: 'appointment'}
            if appointment["calendar"].present?
                user_account&.appointments.create(appointment_id: appointment["id"], firstname: appointment["firstName"], lastname: appointment["lastName"], phone: appointment["phone"], email: appointment["email"], date: appointment["date"], time: appointment["time"], endtime: appointment["endTime"], price: appointment["price"], appointment_type: appointment["type"], calendar: appointment["calendar"], calendar_id: appointment["calendarID"], canceled: appointment["canceled"], transaction_id: appointment_params[:transaction_id])
                BxBlockPushNotifications::FcmSendNotification.new("Your skin consultation with our expert has been booked for:  #{appointment_params[:datetime].to_time.strftime("%d %b %Y - %I:%M %P")} GMT+1, #{appointment["calendar"]} is looking forward to meeting with you then.", "Skin consultation booked", user_account&.device_token, payload_data).call
                AppointmentMailer.with(account: user_account, email: appointment_params[:email], therapist: appointment["calendar"], datetime: appointment['datetime']).appointment_booked.deliver
            end
            if !appointment["type"].downcase.include?("next") and user_account&.membership_plan[:plan_type] == "free"
                no_of_weeks = ConsultationAddonPrice&.first&.weeks || 0
                user_account&.membership_plans.create(plan_type: 'glow_getter', start_date: Time.now, end_date: (Time.now + no_of_weeks.weeks).end_of_day) unless no_of_weeks == 0
            end
            render json: {appointment: appointment}
        elsif appointment.present? and appointment["id"] == nil
            AppointmentMailer.with(account: user_account, email: appointment_params[:email], error: appointment).appointment_not_booked.deliver
            render json: {appointment: appointment}, status: appointment["status_code"]
        else
            render json: {appointment: appointment}, status: 500
        end
        
    end

    def show
      appointment = @@acuity.show(params[:id])
      render json: {appointment: appointment}
    end

    def video_room
        appointment = @@acuity.show(params[:id])
        room_name = appointment["calendar"].split(" ").first.upcase + "_" + params[:id]

        # if Date.parse(appointment["date"]) < Date.today or (Date.parse(appointment["date"]) == Date.today and Time.parse(appointment["endTime"]) < Time.now)
        #     render json: {room: {status: "expired"}, meta: {message: "Appointment is completed!"}}, status: 401
        # elsif Date.parse(appointment["date"]) > Date.today or (Date.parse(appointment["date"]) == Date.today and (Time.parse(appointment["time"]) - Time.now)/60 > 5)
        #     render json: {room: {status: 'not_found'}, meta: {message: "You can join the room only 5 mins before the appointment!"}}, status: 404
        # else
        message = ""
        token = ""
        chat_token = ""
        status = 200
        sid = AppointmentSid.find_by(appointment_id: params[:id])&.sid
            room = @@twilio.show(room_name)
            if room["status"] == 404 and (@account.role.name.downcase == "therapist" || @account.role.name.downcase == "admin")
                @customer = AccountBlock::Account.find_by('LOWER(email) = ?', appointment["email"].downcase)
                if @customer.nil?
                    message = "Customer is not registered with us."
                    status = 404
                else

                    body = "UniqueName=#{room_name}&RecordParticipantsOnConnect=True&Type=group"
                    room = @@twilio.create(body)
                    token = get_token(room_name)
                    # sid = service_sid(room_name)
                    conversation = conversation_sid(room_name)
                    sid = conversation[:sid]
                    appointment_sid = AppointmentSid.find_or_create_by(appointment_id: params[:id])
                    appointment_sid.update(sid: conversation[:sid])
                    chat_token = get_chat_token(conversation[:chat_service_sid])

                    participant_sid = participant_sid(conversation[:sid], @account)

                    one_to_one_chat = @account.customer_chats.find_or_create_by(account_id: @customer.id)




                    one_to_one_chat.update(status: 'active', end_date: 8.weeks.after.end_of_day) if one_to_one_chat.status == 'inactive'
                    chat_id = one_to_one_chat.id
                    payload_data = {account: @account, notification_key: 'appointment_started', inapp: true, push_notification: true, redirect: 'join_call', key: 'appointment'}
                    room_data = {
                        sid: conversation[:sid],
                        room_name: room_name
                    }
                    # BxBlockPushNotifications::FcmSendNotification.new("#{appointment["calendar"]} has started your skin consultation - Join now!", "Video streaming started", [@customer.device_token], payload_data, room_data).call
                    @@notification.user_notifications(room_name, "customer", "consultation", "Your consultation has started", "#{appointment["calendar"]} has started your skin consultation - Join now!", appointment["email"], sid)
                user_id = @customer.id
                end
                owner_id = @account.id


            elsif room["status"] == 404
                message = "Wait for therapist to start the call!"
                message = "Consultation has ended!" if Time.parse(appointment["datetime"]).utc + appointment["duration"].to_i.minutes <= Time.now.utc
                status = 404
                chat_id = nil
            else
                token = get_token(room_name)
                chat_service_sid = conversation_service_sid(sid)
                chat_token = get_chat_token(chat_service_sid)
                therapist = AccountBlock::Account.find_by(acuity_calendar: appointment["calendarID"])
                therapist = AdminUser.find_by(acuity_calendar: appointment["calendarID"]) if therapist.nil?
                puts "**********"
                puts "therapist is: #{therapist.inspect}"
                puts "**********"
                puts "chats are: #{@account.chats.where(therapist: therapist).inspect}"
                puts "**********"
                puts "chat is: #{@account.chats.where(therapist: therapist).first.inspect}"
                puts "**********"
                chat_id = @account.chats.where(therapist: therapist).first&.id
                participant_sid = participant_sid(sid, @account)
            end

            
            if owner_id.present? && user_id.present?
                render json: { room: room, token: token, sid: sid, participant_sid: participant_sid, chat_token: chat_token, message: message, owner_id: owner_id, chat_id: chat_id , user_id: user_id}, status: status
            else
                render json: { room: room, token: token, sid: sid, participant_sid: participant_sid, chat_token: chat_token, message: message, chat_id: chat_id }, status: status
            end
        # end
    end

    def end_video_chat
        appointment = @@acuity.show(params[:id])
        room_name = appointment["calendar"].split(" ").first.upcase + "_" + params[:id]
        @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
        room = @client.video.rooms(room_name).update(status: 'completed')
        # payload_data = {account: @account, notification_key: 'video_streaming_ended', inapp: true, push_notification: true, redirect: 'Link to the live video once it is approved to show on the application', key: 'appointment'}
        # BxBlockPushNotifications::FcmSendNotification.new("Skin Deep was live - view here!", "Live streaming ended", @account.device_token, payload_data).call
        render json: {message: "room completed", room_status: room.status, room: room.unique_name}
    end

    def cancel
        response = @@acuity.cancel(params[:id], cancel_params)
        payload_data = {account: @account, notification_key: 'appointment_cancelled', inapp: true, push_notification: true, redirect: 'calendar', key: 'appointment'}
        BxBlockPushNotifications::FcmSendNotification.new("Your skin consultation is cancelled  #{DateTime.now}", "Appointment is cancelled", @account.device_token, payload_data).call
        AppointmentMailer.with(account: @account, email: @account.email).appointment_cancelled.deliver
        appointment = BxBlockAppointmentManagement::Appointment.find_by(appointment_id: params[:id])
        appointment.update(canceled: true)
        stripe, error = BxBlockPayments::StripePayment.stripe_refund(amount: appointment.price.to_i, charge_id: appointment.transaction_id)
        if stripe.present? && stripe.status == "succeeded"
            @refund = BxBlockPayments::Refund.new(charge_id: appointment.transaction_id, refund_id: stripe.id)
            @refund.save
            render json: {data: {message: "Refund is successful.", refund: @refund, order_response: response}}
        else
            render json: {errors: {message: "Unsuccessful refund."}}, status: :unprocessable_entity
        end
    end

    def reschedule
        response = @@acuity.reschedule(params[:id], reschedule_params)
        payload_data = {account: @account, notification_key: 'appointment_rescheduled', inapp: true, push_notification: true, redirect: 'calendar', key: 'appointment'}
        BxBlockPushNotifications::FcmSendNotification.new("Your skin consultation date and time has been changed to:  #{reschedule_params[:datetime]}", "Skin consultation is rescheduled", @account.device_token, payload_data).call
        AppointmentMailer.with(account: @account, reschedule_time: reschedule_params[:datetime], email: @account.email).appointment_rescheduled.deliver
        render json: response
    end

    def customer_appointments
        appointments = @@acuity.customer_appointments(params[:email])
        render json: {appointments: appointments}
    end

    def therapist_appointments
        appointments = @@acuity.therapist_appointments(params[:calendarId])
        render json: {appointments: appointments}
    end

    def index
        appointments = @@acuity.index(params[:calendarID], params[:minDate], params[:maxDate])
        appointments.map {|a| a["time"] = Time.strptime(a["time"], "%I:%M %P").strftime('%l:%M%P')
                                a['user_id']=AccountBlock::Account.find_by(email: a['email'])&.id
                                a["endTime"] = Time.strptime(a["endTime"], "%I:%M %P").strftime('%l:%M%P')
                                a["startVideo"] = (Time.parse(a["datetime"]).utc - 15.minutes <= Time.now.utc && Time.parse(a["datetime"]).utc + a["duration"].to_i.minutes >= Time.now.utc) }
        render json: {appointments: appointments}
    end


    def available_dates
        dates = @@acuity.available_dates(params[:calendarID], params[:appointmentTypeID], params[:month])
        render json: {available_dates: dates}
    end

    def available_times
        time = @@acuity.available_times(params[:calendarID], params[:appointmentTypeID], params[:date])
        render json: {available_times: time}
    end

    private

    def service_sid(room_name)
        @client = Twilio::REST::Client.new(@@account_sid, @@auth_token)
        service = @client.chat.services.create(friendly_name: room_name)
        service.sid
    end

    def get_token(room_name)
        identity = @account&.name.to_s
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

    def get_chat_token(sid)
        identity = @account&.email

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

    def appointment_params
        params['data'].permit(:datetime, :appointmentTypeID, :firstName, :lastName, :email, :calendarID, :phone, :age, :address, :transaction_id)
    end

    def cancel_params
        params['data'].permit(:cancelNote)
    end

    def reschedule_params
        params['data'].permit(:datetime)
    end

    def get_user
        @account = AccountBlock::Account.find(@token.id) unless @token.account_type == "AdminAccount"
        @account = AdminUser.find(@token.id) if @token.account_type == "AdminAccount"
        @account
      end
  end
end
