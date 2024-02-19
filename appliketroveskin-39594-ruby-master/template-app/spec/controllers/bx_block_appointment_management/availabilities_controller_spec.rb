require 'rails_helper'
require 'spec_helper'

RSpec.describe BxBlockAppointmentManagement::AvailabilitiesController, type: :controller do
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

    describe 'POST create' do
        before do
            @account = create(:account , freeze_account: false)
            # @appointment = create(:appointment)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
            @availability = create(:availability, service_provider: @account)
        end

        context "when pass correct params" do
            it 'Returns success.' do
                post :create, params: { use_route: "/appointments/" , token: @token , service_provider_id: @account.id, availability:{ start_time: @availability.start_time , end_time: @availability.end_time, availability_date: @availability.availability_date } },as: :json
                expect(response).to have_http_status(200)
            end
        end
    end

    describe 'GET index' do
        before do
            @account = create(:account , freeze_account: false)
            # @appointment = create(:appointment)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
            @availability = create(:availability, service_provider: @account)
        end

        context "when pass correct params" do
            it 'Returns success.' do
                get :index, params: { use_route: "/appointments/" , token: @token, service_provider_id: @availability.id , availability_date: @availability.availability_date  },as: :json
                expect(response).to have_http_status(200)
            end
        end
    end
    describe 'DELETE delete_all' do
        before do
            @account = create(:account , freeze_account: false)
            # @appointment = create(:appointment)
            @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
            @availability = create(:availability, service_provider: @account)
        end

        context "when pass correct params" do
            it 'Returns success.' do
                delete :delete_all, params: { use_route: "/appointments/" , token: @token, service_provider_id: @availability.id },as: :json
                expect(response).to have_http_status(204)
            end
        end
    end
end
