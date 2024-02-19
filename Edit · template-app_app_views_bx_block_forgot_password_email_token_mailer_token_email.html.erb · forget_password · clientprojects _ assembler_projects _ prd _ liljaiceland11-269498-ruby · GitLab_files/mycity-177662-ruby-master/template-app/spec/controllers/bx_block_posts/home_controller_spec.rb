require 'rails_helper'

RSpec.describe BxBlockPosts::HomeController, type: :controller do
	let(:hidden_place_type) { BxBlockAnalytics9::SearchDocument.create(content: 'new test place', searchable_type: 'Google Place', name: 'Test place', location: 'madurai', status: 'approved') }
	let(:social_club) {create(:social_club)}

	describe 'Search documents' do
		context 'Search by word' do
			it 'should return match record' do
				hidden_place_type
				get :search, params: { search: 'test' }
				expect(JSON.parse(response.body)['data']).not_to be_nil
				expect(response).to have_http_status(:ok)
			end

			it 'should return match social club record' do
				social_club
				get :search, params: { search: 'test' }
				expect(JSON.parse(response.body)['data']).not_to be_nil
				expect(response).to have_http_status(:ok)
			end
		end

		context 'Search by location' do
			it 'should return match record by place type' do
				hidden_place_type
				get :search_by_location, params: { search: 'test', type: 'places' }
				expect(JSON.parse(response.body)['data']).not_to be_nil
				expect(response).to have_http_status(:ok)
			end

			it 'should return match social club record by type' do
				social_club
				get :search_by_location, params: { search: 'test', type: 'clubs' }
				expect(JSON.parse(response.body)['data']).not_to be_nil
				expect(response).to have_http_status(:ok)
			end
		end
	end
end