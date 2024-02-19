require 'rails_helper'
RSpec.describe BxBlockSkinDiary::SkincareStepsController, type: :controller do

  describe 'POST CREATE' do
    before do
      @therapist = create(:account, :with_therapist_role)
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        routine = create(:skincare_routine, account: @account, therapist: @therapist)
        step_params = { skincare_routine_id: routine.id, step: 'Cleanser'}
        post :create, params: { use_route: "/payments/" , token: @token, skincare_step: step_params }
        expect(response).to have_http_status(200)
      end
    end
    # context "when pass correct params" do
    #   it 'Returns success' do
    #     routine = create(:skincare_routine, account: @account, therapist: @therapist)
    #     # step_params = { skincare_routine_id: routine.id, step: 'Cleanser', skincare_products_attributes: { [ { product_id: 7549058744539, name: "ACE Body Oil", image_url: "https://cdn.shopify.com/" } ]} }, as: :json
    #     post :create, params: { use_route: "/payments/" , token: @token, skincare_step: { skincare_routine_id: routine.id, step: 'Cleanser', skincare_products_attributes: { [ { product_id: 7549058744539, name: "ACE Body Oil", image_url: "https://cdn.shopify.com/" } ]} } }, as: :json
    #     expect(response).to have_http_status(200)
    #   end
    # end
  end

  describe 'PUT UPDATE' do
    before do
      @therapist = create(:account, :with_therapist_role)
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        routine = create(:skincare_routine, account: @account, therapist: @therapist)
        step = create(:skincare_step, skincare_routine: routine)
        # products_attributes = { [product_id: 7549058744539, name: "ACE Body Oil", image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/100ml-body-oil-with-shadow-508x720-1301c14b-191f-44b9-8030-ceda26cc4425_350x350_a6498e01-304a-4afa-8a8d-05cb26550853.png?v=1645521988" ] }, as: :json
        # skincare_products_attributes: { [id: , product_id: , name: , image_url: ] }, skincare_step_notes_attributes: { [id: , comment: ]
        step_params = { skincare_routine_id: routine.id, step: 'Cleanser'}
        put :update, params: { use_route: "/payments/" , token: @token, skincare_step: step_params, id: step.id}
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE delete_comment' do
    before do
      @therapist = create(:account, :with_therapist_role)
      @account = create(:account , freeze_account: false)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when pass correct params" do
      it 'Returns success' do
        routine = create(:skincare_routine, account: @account, therapist: @therapist)
        step = create(:skincare_step, skincare_routine: routine)
        skincare_step_note = create(:skincare_step_note, skincare_step: step)
        step_params = { skincare_routine_id: routine.id, step: 'Cleanser'}
        delete :delete_comment, params: { use_route: "/payments/" , token: @token, id: skincare_step_note.id}
        expect(response).to have_http_status(200)
      end
    end

  context "when pass incorrect params" do
      it 'Returns success' do
        routine = create(:skincare_routine, account: @account, therapist: @therapist)
        step = create(:skincare_step, skincare_routine: routine)
        step_params = { skincare_routine_id: routine.id, step: 'Cleanser'}
        delete :delete_comment, params: { use_route: "/payments/" , token: @token}
        expect(response).to have_http_status(404)
      end
    end
  end
end



