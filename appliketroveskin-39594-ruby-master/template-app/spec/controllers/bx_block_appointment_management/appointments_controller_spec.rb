require 'rails_helper'
require 'spec_helper'

RSpec.describe BxBlockAppointmentManagement::AppointmentsController, type: :controller do
    let(:admin) { create(:admin_user) }
    let(:acuity) { BxBlockAppointmentManagement::AcuityController.new }
    let(:appointmentTypeID) { acuity.appointment_types&.first['id'] }
    let(:calendar_id) { acuity.appointment_types&.first['calendarIDs'].first }
    let(:customer) { create(:email_account) }
    let(:available_date) { acuity.available_dates(calendar_id, appointmentTypeID, Time.now.strftime("%Y-%m")).first['date'] }
    let(:available_date2) { acuity.available_dates(calendar_id, appointmentTypeID, (1.day.after).strftime("%Y-%m")).first['date'] }
    let(:available_time) { acuity.available_times(calendar_id, appointmentTypeID, available_date).first['time'] }
    let(:available_time2) { acuity.available_times(calendar_id, appointmentTypeID, available_date).first['time'] }
    let(:appointment_params) { {datetime: available_time, appointmentTypeID: appointmentTypeID, firstName: "test_name", lastName: "last_test_name", email: "testrspec12@yopmail.com", calendarID: calendar_id, phone: "+919786563251", age: "45", address: "Adress is nsiadfgvbgfd", transaction_id: "TRANSACTION1" } }
    let(:appointment) { acuity.create(appointment_params) }
    describe 'GET types' do
        before do
            @account = create(:account , freeze_account: false)
            # @appointment = create(:appointment)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    
         
        context "when pass correct params" do
            it 'Returns success.' do
                get :types, params: { use_route: "/appointments/" , token: @token  },as: :json
                expect(response).to have_http_status(200)
            end
        end

        context "when pass incorrect params" do
            it 'Returns Invalid token' do
                get :types, params: { use_route: "/appointments/" , token: nil  }
                expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
            end
        end
    end


    describe 'GET therapists' do
        before do
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@therapist.id, {jwt_token: @therapist.jwt_token, account_type: @therapist.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                get :therapists, params: { use_route: "/appointments/" , token: @token , id: @therapist.id }
                expect(response).to have_http_status(200)
            end
        end

        context "when pass incorrect params" do
            it 'Returns Invalid token' do
                get :therapists, params: { use_route: "/appointments/" , token: nil }
                expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
            end
        end
    end

    describe 'GET admin_list' do
        before do
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@therapist.id, {jwt_token: @therapist.jwt_token, account_type: @therapist.type}, 1.year.from_now)
            admin
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                get :admin_list, params: { use_route: "/appointments/" , token: @token , id: @therapist.id }
                expect(response).to have_http_status(200)
            end
            it 'Returns success.' do
                get :admin_list, params: { use_route: "/appointments/" , token: @token , id: @therapist.id }
                expect(response).to have_http_status(200)
            end
        end

        context "when pass incorrect params" do
            it 'Returns Invalid token' do
                get :admin_list, params: { use_route: "/appointments/" , token: nil }
                expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
            end
        end
    end



    describe 'POST show' do
        before do
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@therapist.id, {jwt_token: @therapist.jwt_token, account_type: @therapist.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                post :show, params: { use_route: "/appointments/" , token: @token , id: @therapist.id }
                expect(response).to have_http_status(200)
            end
        end

        context "when pass incorrect params" do
            it 'Returns Invalid token' do
                post :show, params: { use_route: "/appointments/" , token: nil }
                expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
            end
        end
    end


    describe 'POST video_room' do
        before do
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@therapist.id, {jwt_token: @therapist.jwt_token, account_type: @therapist.type}, 1.year.from_now)
            @customer = create(:email_account, role: BxBlockRolesPermissions::Role.find_or_create_by(name: "User"))
        end    
        context "when pass correct params" do
            it 'Returns success.' do
                @therapist.update(acuity_calendar: calendar_id)
                appointment_params =  { datetime: available_time, appointmentTypeID: appointmentTypeID, firstName: "test_name", lastName: "last_test_name", email: @customer.email, calendarID: calendar_id, phone: "+919786563251", age: "45", address: "Adress is nsiadfgvbgfd", transaction_id: "TRANSACTION1" }
                appointment =  acuity.create(appointment_params)
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @customer)
                post :video_room, params: { use_route: "/appointments/" , token: @token , id: acuity_appointment['id'] }
                # expect(JSON.parse(response.body)['room'].keys).to match_array(["account_sid", "audio_only", "date_created", "date_updated", "duration", "empty_room_timeout", "enab...ack", "status_callback_method", "type", "unique_name", "unused_room_timeout", "url", "video_codecs"])
                # expect(JSON.parse(response.body).keys).to match_array(["room", "token", "sid", "participant_sid", "chat_token", "message", "chat_id"])
                expect(response).to have_http_status(200)
            end
        end
    end


    describe 'GET therapist_appointments' do
        before do
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@therapist.id, {jwt_token: @therapist.jwt_token, account_type: @therapist.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                get :therapist_appointments, params: { use_route: "/appointments/" , token: @token , id: @therapist.id }
                expect(response).to have_http_status(200)
            end
        end
    end

    describe 'DELETE cancel' do
        let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) } 
        let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) } 
        let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) } 
        let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) } 
        let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }
        before do
            email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
            @account = create(:email_account, :with_user_role, freeze_account: false)
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @account,)
                delete :cancel, params: { use_route: "/appointments/" , token: @token , data: { cancelNote: "Some cancel note" }, id: acuity_appointment['id'] }
                expect(@account.notifications.last.headings).to eql("Appointment is cancelled")
                expect(response).to have_http_status(422)
                expect(JSON.parse(response.body)['errors']['message']).to eql("Unsuccessful refund.")
            end
        end
    end

    describe 'PUT reschedule' do
        let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) } 
        let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) } 
        let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) } 
        let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) } 
        let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }
        before do
            email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
            @account = create(:email_account, :with_user_role, freeze_account: false)
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @account,)
                put :reschedule, params: { use_route: "/appointments/" , token: @token , data: { datetime: available_time2 }, id: acuity_appointment['id'] }
                # sample = ["id", "firstName", "lastName", "phone", "email", "date", "time", "endTime", "dateCreated", "datetimeCreated", "datetime", "price", "priceSold", "paid", "amountPaid", "type", "appointmentTypeID", "classID", "addonIDs", "category", "duration", "calendar", "calendarID", "certificate", "confirmationPage", "location", "notes", "timezone", "calendarTimezone", "canceled", "canClientCancel", "canClientReschedule", "labels", "forms", "formsText", "isVerified", "scheduledBy"]
                expect(response).to have_http_status(200)
                # expect(JSON.parse(response.body).keys).to match_array(sample)
                # expect(@account.notifications.last.headings).to eql("Skin consultation is rescheduled")
            end
        end
    end

    describe 'GET customer_appointments' do
        before do
            @account = create(:email_account, :with_user_role, freeze_account: false)
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @account,)
                get :customer_appointments, params: { use_route: "/appointments/" , token: @token , email: "testrspec12@yopmail.com" }
                sample = ["id", "firstName", "lastName", "phone", "email", "date", "time", "endTime", "dateCreated", "datetimeCreated", "datetime", "price", "priceSold", "paid", "amountPaid", "type", "appointmentTypeID", "classID", "addonIDs", "category", "duration", "calendar", "calendarID", "certificate", "confirmationPage", "location", "notes", "timezone", "calendarTimezone", "canceled", "canClientCancel", "canClientReschedule", "labels", "forms", "formsText"]
                expect(response).to have_http_status(200)
                expect(JSON.parse(response.body)['appointments'].first.keys).to match_array(sample)
            end
        end
    end

    describe 'GET therapist_appointments' do
        before do
            @account = create(:email_account, :with_user_role, freeze_account: false)
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @account,)
                get :therapist_appointments, params: { use_route: "/appointments/" , token: @token , calendarId: calendar_id }
                sample = ["id", "firstName", "lastName", "phone", "email", "date", "time", "endTime", "dateCreated", "datetimeCreated", "datetime", "price", "priceSold", "paid", "amountPaid", "type", "appointmentTypeID", "classID", "addonIDs", "category", "duration", "calendar", "calendarID", "certificate", "confirmationPage", "location", "notes", "timezone", "calendarTimezone", "canceled", "canClientCancel", "canClientReschedule", "labels", "forms", "formsText"]
                expect(response).to have_http_status(200)
                expect(JSON.parse(response.body)['appointments'].first.keys).to match_array(sample)
            end
        end
    end

    describe 'GET index' do
        before do
            @account = create(:email_account, :with_user_role, freeze_account: false)
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @account,)
                get :index, params: { use_route: "/appointments/" , token: @token , calendarID: calendar_id, minDate: (1.day.ago).strftime("%d/%m/%Y"), maxDate: (1.day.after).strftime("%d/%m/%Y") }
                sample = ["id", "firstName", "lastName", "phone", "email", "date", "time", "endTime", "dateCreated", "datetimeCreated", "datetime", "price", "priceSold", "paid", "amountPaid", "type", "appointmentTypeID", "classID", "addonIDs", "category", "duration", "calendar", "calendarID", "certificate", "confirmationPage", "location", "notes", "timezone", "calendarTimezone", "canceled", "canClientCancel", "canClientReschedule", "labels", "forms", "formsText", "user_id", "startVideo"]
                expect(response).to have_http_status(200)
                expect(JSON.parse(response.body)['appointments'].first.keys).to match_array(sample)
            end
        end
    end

    describe 'GET available_dates' do
        before do
            @account = create(:email_account, :with_user_role, freeze_account: false)
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @account,)
                get :available_dates, params: { use_route: "/appointments/" , token: @token , calendarID: calendar_id, appointmentTypeID: appointmentTypeID, month: Time.now.strftime("%Y-%m") }
                expect(response).to have_http_status(200)
                expect(JSON.parse(response.body)['available_dates'].first.keys).to match_array(["date"])
            end
        end
    end

    describe 'GET available_times' do
        before do
            @account = create(:email_account, :with_user_role, freeze_account: false)
            @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end    

        context "when pass correct params" do
            it 'Returns success.' do
                acuity_appointment = appointment
                local_appointment = create(:appointment, appointment_id: acuity_appointment['id'], account: @account,)
                get :available_times, params: { use_route: "/appointments/" , token: @token , calendarID: calendar_id, appointmentTypeID: appointmentTypeID, date: 2.days.from_now.strftime("%Y-%m-%d") }
                expect(response).to have_http_status(200)
                # expect(JSON.parse(response.body)['available_times'].first.keys).to match_array(["time", "slotsAvailable"])
            end
        end
    end


    describe 'POST create' do
        before do
            @account = create(:email_account, :with_user_role, freeze_account: false)
            # @therapist = create(:account, :with_therapist_role , freeze_account: false)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end  
        let(:therapist) { create(:account, :with_therapist_role , freeze_account: false) }
        let(:acuity) { BxBlockAppointmentManagement::AcuityController.new }
        let(:appointment_types) { acuity.appointment_types }
        let(:calendar_id) { appointment_types&.first['calendarIDs'].first }
        let(:appointmentTypeID) { appointment_types&.first['id'] }
        let(:available_dates) { acuity.available_dates(calendar_id, appointmentTypeID, Time.now.strftime("%Y-%m")) }
        let(:available_time) { acuity.available_times(calendar_id, appointmentTypeID, available_dates.first['date']) }
        let(:profile_pic) { create(:dynamic_image, image_type: "profile_pic" ) } 
        let(:skin_quiz) { create(:skin_quiz, question_type: "consultation", active: true) }
        let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) } 
        let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) } 
        let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) } 
        let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) } 
        let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }
        let(:consultation_addon_price) { create(:consultation_addon_price, weeks: 6) }

        context "when pass correct params" do
            it 'Returns success.' do
                # ENV["TEST_ENV"] = "true"
                id = @account.id
                profile_pic && skin_quiz &&  email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image && consultation_addon_price
                token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
                therapist.update(acuity_calendar: appointment_types&.first['calendarIDs'].first)
                post :create, params: { use_route: "/chat/" , token: token  , data: {datetime: available_time.first['time'], appointmentTypeID: appointmentTypeID, calendarID: calendar_id, firstName: "Test", lastName: "Name", phone: "9999999999", address: "full address", age: 23, email: "test@email.com" } }
                sample = ["id", "firstName", "lastName", "phone", "email", "date", "time", "endTime", "dateCreated", "datetimeCreated", "datetime", "price", "priceSold", "paid", "amountPaid", "type", "appointmentTypeID", "classID", "addonIDs", "category", "duration", "calendar", "calendarID", "certificate", "confirmationPage", "location", "notes", "timezone", "calendarTimezone", "canceled", "canClientCancel", "canClientReschedule", "labels", "forms", "formsText", "isVerified", "scheduledBy"]
                expect(JSON.parse(response.body)['appointment'].keys).to match_array(sample)
                expect(AccountBlock::Account.find_by(id: id).membership_plan.plan_type).to eq("glow_getter")
                expect(response).to have_http_status(200)
            end
        end
        context "when test env is not present" do
            it 'Returns success.' do
                ENV["TEST_ENV"] = "true"
                id = @account.id
                profile_pic && skin_quiz &&  email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image && consultation_addon_price
                token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
                therapist.update(acuity_calendar: appointment_types&.first['calendarIDs'].first)
                post :create, params: { use_route: "/chat/" , token: token  , data: {datetime: available_time.first['time'], appointmentTypeID: appointmentTypeID, calendarID: calendar_id, firstName: "Test", lastName: "Name", phone: "9999999999", address: "full address", age: 23, email: "test@email.com" } }
                sample = ["id", "firstName", "lastName", "phone", "email", "date", "time", "endTime", "dateCreated", "datetimeCreated", "datetime", "price", "priceSold", "paid", "amountPaid", "type", "appointmentTypeID", "classID", "addonIDs", "category", "duration", "calendar", "calendarID", "certificate", "confirmationPage", "location", "notes", "timezone", "calendarTimezone", "canceled", "canClientCancel", "canClientReschedule", "labels", "forms", "formsText", "isVerified", "scheduledBy"]
                expect(JSON.parse(response.body)['appointment'].keys).to match_array(sample)
                expect(AccountBlock::Account.find_by(id: id).membership_plan.plan_type).to eq("glow_getter")
                expect(response).to have_http_status(200)
            end
        end

    end
end
