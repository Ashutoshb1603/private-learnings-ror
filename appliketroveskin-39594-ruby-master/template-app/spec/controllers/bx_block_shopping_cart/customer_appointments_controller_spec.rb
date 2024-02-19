require 'rails_helper'
RSpec.describe BxBlockShoppingCart::CustomerAppointmentsController, type: :controller do

	describe 'GET get_sp_details' do
		before do
			@account = create(:account , freeze_account: false)
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end

		context "when pass correct params" do
			it 'Returns success' do
				get :customer_orders, params: { use_route: "/payments/" , token: @token }
				expect(response).to have_http_status(200)
			end
			it 'Returns success' do
				address = create(:address, addressable: @account )
      			order = create(:order , customer: @account, address: address, status: 'completed')
				create(:availability, service_provider: @account)
				get :customer_orders, params: { use_route: "/payments/" , token: @token, filter_by: 'history'}, as: :json
				expect(response).to have_http_status(200)
			end
		end
	end

	describe 'PATCH update_notification_setting' do
		before do
			@account = create(:account , freeze_account: false)
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end

		context "when pass correct params" do
			it 'Returns success' do
				address = create(:address, addressable: @account )
      			order = create(:order , customer: @account, address: address, status: 'completed')
				patch :update_notification_setting, params: { use_route: "/payments/" , token: @token, id: order.id}
				expect(response).to have_http_status(200)
			end
			# it 'Returns success' do
			# 	address = create(:address, addressable: @account )
   #    			order = create(:order , customer: @account, address: address, status: 'completed')
			# 	create(:availability, service_provider: @account)
			# 	patch :update_notification_setting, params: { use_route: "/payments/" , token: @token, filter_by: 'history'}, as: :json
			# 	expect(response).to have_http_status(200)
			# end
		end
	end

end
