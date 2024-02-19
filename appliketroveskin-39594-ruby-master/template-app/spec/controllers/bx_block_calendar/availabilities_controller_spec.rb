# require 'rails_helper'
# RSpec.describe BxBlockCalendar::AvailabilitiesController, type: :controller do

#    describe 'GET INDEX' do
#       before do
#          @account = create(:account, freeze_account: false)
#          @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
#          featured = create(:featured_post)
#       end

#       context "when pass correct params" do
#          it 'Returns success' do
#             get :index, params: { token: @token }, as: :json
#             expect(response).to have_http_status(200)
#             # expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(["id", "position", "account_id", "created_at", "updated_at", "image"])
#          end
#       end
#        context "when pass correct params" do
#          before do
#             create(:featured_post)
#          end
#          it 'Returns success' do
#             get :index, params: { token: @token }, as: :json
#             expect(response).to have_http_status(200)
#             # expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(["id", "position", "account_id", "created_at", "updated_at", "image"])
#          end
#       end
#    end

# end
