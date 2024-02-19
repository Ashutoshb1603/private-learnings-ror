require 'rails_helper'
RSpec.describe BxBlockShoppingCart::AvailabilitiesController, type: :controller do

	describe 'GET get_sp_details' do
		before do
			@account = create(:account , freeze_account: false)
			@token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
		end

		context "when pass correct params" do
			it 'Returns success' do
				get :get_booked_time_slots, params: { use_route: "/payments/" , token: @token }
				expect(response).to have_http_status(200)
			end
			it 'Returns success' do
				create(:availability, service_provider: @account)
				get :get_booked_time_slots, params: { use_route: "/payments/" , token: @token, service_provider_id: @account.id, booking_date: Date.today }, as: :json
				expect(response).to have_http_status(200)
			end
		end
	end
end
