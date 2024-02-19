require 'rails_helper'

RSpec.describe AccountBlock::AccountsController, type: :controller do

	describe 'Create new user account' do
		let(:create_params) do
			{
				full_name: 'Siva Aps',
				user_name: 'Siva Aps', 
				email: 'aps@gmail.com'
			}
		end

		context 'Create' do
			it 'should create new account' do
				expect {
					post :create, params: {data: {attributes: create_params}}
				}.to change {AccountBlock::Account.count}
			end

			it 'should create new account with given email' do
				expect {
					post :create, params: {data: {attributes: create_params}}
				}.to change {AccountBlock::Account.count}

				expect(AccountBlock::Account.last.email).to eq ('aps@gmail.com')
			end

			it 'should create new account with arabic preferred language' do
				expect {
					post :create, params: {data: {attributes: create_params.merge(language: 'arabic')}}
				}.to change {AccountBlock::Account.count}
			
				expect(AccountBlock::Account.last.reload.preferred_language).to eq ('arabic')
			end

		end
	end
end