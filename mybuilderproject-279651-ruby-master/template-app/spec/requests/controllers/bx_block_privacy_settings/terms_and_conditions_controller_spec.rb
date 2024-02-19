require 'rails_helper'
RSpec.describe BxBlockPrivacySettings::TermsAndConditionsController, :type=>:controller do 
	before(:all) do
		if BxBlockPrivacySettings::TermsAndCondition.count<1
			@terms_and_condition=FactoryBot.create(:terms_and_condition)
		end
	end
	describe 'bx_block_privacy_settings/terms_and_conditions/:id' do
		it 'should return terms and conditions' do
			get :show, format: :json, params: {id: 2}
			expect(response).to have_http_status(:ok)
		end
		it 'should return error' do
			BxBlockPrivacySettings::TermsAndCondition.destroy_all
			get :show, format: :json, params: {id: 1}
			expect(response).to have_http_status(:not_found)
		end
	end
end