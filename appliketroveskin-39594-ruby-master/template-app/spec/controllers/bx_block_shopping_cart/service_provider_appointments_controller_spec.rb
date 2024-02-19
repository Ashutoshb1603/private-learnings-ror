require 'rails_helper'
RSpec.describe BxBlockShoppingCart::ServiceProviderAppointmentsController, type: :controller do

	describe 'GET filter_order' do
		before do
			@account = create(:account , freeze_account: false)
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end

		context "when pass correct params" do
			it 'Returns success' do
				address = create(:address, addressable: @account )
      			order = create(:order , customer: @account, address: address, status: 'completed')
				get :filter_order, params: { use_route: "/payments/" , token: @token, filter_by: 'history' }
				expect(response).to have_http_status(200)
			end
			it 'Returns success' do
				address = create(:address, addressable: @account )
      			order = create(:order , customer: @account, address: address)
				get :filter_order, params: { use_route: "/payments/" , token: @token, service_provider_id: @account.id, booking_date: Date.today }, as: :json
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'GET start_order' do
		before do
			@account = create(:account , freeze_account: false)
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end

		context "when pass correct params" do
			it 'Returns success' do
				address = create(:address, addressable: @account )
      			order = create(:order , customer: @account, address: address, status: 'completed')
				get :start_order, params: { use_route: "/payments/" , token: @token, id: order.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'GET finish_order' do
		before do
			@account = create(:account , freeze_account: false)
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end

		context "when pass correct params" do
			it 'Returns success' do
				address = create(:address, addressable: @account )
      			order = create(:order , customer: @account, address: address, status: 'completed')
				get :finish_order, params: { use_route: "/payments/" , token: @token, id: order.id }
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'GET sp_details' do
		before do
			@account = create(:account , freeze_account: false)
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end

		context "when pass correct params" do
			it 'Returns success' do
				create(:availability, service_provider: @account)
				get :get_sp_details, params: { use_route: "/payments/" , token: @token, service_provider_id: @account.id, availability_date: Time.now }
				expect(response).to have_http_status(200)
			end
		end
	end

end
