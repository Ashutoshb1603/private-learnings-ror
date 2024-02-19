require 'rails_helper'
RSpec.describe BxBlockAdmin::ConsultationAnalyticsController, type: :controller do

  describe 'GET index' do
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
      @therapist = create(:email_account, :with_therapist_role, freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      @recommended_product = create(:recommended_product, account: @account, parentable: @therapist, product_id: "7549057564891", title: "Youth EssentiA Vita-Peptide Toner", price: "46.00")
      create(:purchase, recommended_product: @recommended_product, quantity:  1)
      create(:membership_plan, account: @account, plan_type: "glow_getter", end_date: 1.month.after)
    end
    context "when we pass glow_getter plan_type" do
      it 'Returns success' do
        get :index, params: {token: @token, start_date: 1.days.ago.strftime("%d/%m/%Y"), end_date: 1.days.after.strftime("%d/%m/%Y"), plan_type: "glow_getter" }
        expect(response). to have_http_status(200)
        expect(JSON.parse(response.body).keys).to match_array(["data", "average_sale", "total_purchase"])
        expect(JSON.parse(response.body)['data'].first['attributes'].keys). to match_array(["firstname", "lastname", "date", "time", "quantity", "price", "account_id"])
      end
    end
    context "when we pass free plan type params" do
      it 'Returns success' do
        get :index, params: {token: @token, start_date: 1.days.ago.strftime("%d/%m/%Y"), end_date: 1.days.after.strftime("%d/%m/%Y"), plan_type: "free" }
        expect(response). to have_http_status(200)
        expect(JSON.parse(response.body).keys).to match_array(["data", "average_sale", "total_purchase"])
        expect(JSON.parse(response.body)['data'].first['attributes'].keys). to match_array(["firstname", "lastname", "date", "time", "quantity", "price", "account_id"])
      end
    end
    context "when we create categories with correct params" do
      it 'Returns success' do
        get :index, params: {token: @token, therapist_id: @therapist.id, therapist_type: "therapist" }
        expect(response). to have_http_status(200)
        expect(JSON.parse(response.body).keys).to match_array(["data", "average_sale", "total_purchase"])
        expect(JSON.parse(response.body)['data'].first['attributes'].keys). to match_array(["firstname", "lastname", "date", "time", "quantity", "price", "account_id"])
      end
    end
    context "when we create categories with incorrect params" do
      it 'Returns Invalid token' do
        get :index, params: {token: nil}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end
end
