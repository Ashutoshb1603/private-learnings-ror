require 'rails_helper'
RSpec.describe BxBlockAdmin::SkinClinicsController, type: :controller do

  describe 'GET index ' do
  	let(:admin) { create(:admin_user, :with_admin_role, freeze_account: false) }
    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
    end
	context "Only accessible to admin" do
      it 'Returns error' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        get :index, params: {token: token}
        expect(response). to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
      end
    end
    context "When admin logged in" do
    	before do
    		skin_clinic = create(:skin_clinic)
    		skin_clinic_availability = create(:skin_clinic_availability, skin_clinic: skin_clinic)
    	end
    	it 'Returns success' do
	      	user = admin
	      	question_id = create(:question, accountable: admin, recommended: false).id
	      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
	        get :index, params: { token: token }
	        expect(response).to have_http_status(200)
	        expect(JSON.parse(response.body)['data'].first['attributes'].keys).to match_array(["id", "name", "location", "country", "latitude", "longitude", "created_at", "updated_at", "clinic_link", "availabilities"])
      	end
    end
  end

	describe 'POST create ' do
	  	let(:admin) { create(:admin_user, :with_admin_role, freeze_account: false) }
	    before do
	     	@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
	    end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
				post :create, params: {token: token}
				expect(response). to have_http_status(422)
				expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
			end
	    end
	    context "When admin logged in" do
	    	it 'Returns success' do
		      	user = admin
		      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
		      	params = { token: token, data: { attributes: { name: "TestClinicName", location: "Ark Vetcare, 33, Patrick Street, Dun Laoghaire-West Central ED, Dún Laoghaire, Dún Laoghaire-Rathdown, County Dublin, Leinster, A96-NW25, Ireland", longitude: 54.34, latitude: 0.243, clinic_link: "https://www.monicatolan.com", skin_clinic_availabilities_attributes: [ { day: "Monday - Friday", from: "10:00 AM", to: "06:00 PM" }, { day: "Saturday - Sunday", from: "10:00 AM", to: "04:00 PM" } ] } } }
		      	question_id = create(:question, accountable: admin, recommended: false).id
		        post :create, params: params
		        expect(response).to have_http_status(201)
		        expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(["id", "name", "location", "country", "latitude", "longitude", "created_at", "updated_at", "clinic_link", "availabilities"])
	      	end
	      	it 'Returns Error for not saving' do
		      	user = admin
		      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
		      	params = { token: token, data: { attributes: { location: "Ark Vetcare, 33, Patrick Street, Dun Laoghaire-West Central ED, Dún Laoghaire, Dún Laoghaire-Rathdown, County Dublin, Leinster, A96-NW25, Ireland", longitude: 54.34, latitude: 0.243, clinic_link: "", skin_clinic_availabilities_attributes: [ { day: "Monday - Friday", from: "10:00 AM", to: "06:00 PM" }, { day: "Saturday - Sunday", from: "10:00 AM", to: "04:00 PM" } ] } } }
		      	question_id = create(:question, accountable: admin, recommended: false).id
		        post :create, params: params
		        expect(response).to have_http_status(422)
		        expect(JSON.parse(response.body)['errors']['name']).to match_array(["can't be blank"])
	      	end
	    end
	end

	describe 'GET show ' do
	  	let(:admin) { create(:admin_user, :with_admin_role, freeze_account: false) }
	    before do
	     	@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
	    end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
				get :show, params: {token: token, id: 234}
				expect(response). to have_http_status(422)
				expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
			end
	    end
	    context "When admin logged in" do
	    	before do
	    	end
	    	it 'Returns success' do
		      	user = admin
	    		skin_clinic = create(:skin_clinic)
    			skin_clinic_availability = create(:skin_clinic_availability, skin_clinic: skin_clinic)
		      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
		      	params = { token: token, id: skin_clinic.id}
		      	question_id = create(:question, accountable: admin, recommended: false).id
		        get :show, params: params
		        expect(response).to have_http_status(200)
		        expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(["id", "name", "location", "country", "latitude", "longitude", "created_at", "updated_at", "clinic_link", "availabilities"])
	      	end
	    end
	end

	describe 'PUT update ' do
	  	let(:admin) { create(:admin_user, :with_admin_role, freeze_account: false) }
	    before do
	     	@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
	    end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
				put :update, params: {token: token, id: 1234}
				expect(response). to have_http_status(422)
				expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
			end
	    end
	    context "When admin logged in" do
	    	it 'Returns success' do
		      	user = admin
		      	skin_clinic = create(:skin_clinic)
		      	id = skin_clinic.id
    			skin_clinic_availability = create(:skin_clinic_availability, skin_clinic: skin_clinic)
		      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
		      	params = { token: token, id: id, data: { attributes: { name: "TestClinicName", location: "Ark Vetcare, 33, Patrick Street, Dun Laoghaire-West Central ED, Dún Laoghaire, Dún Laoghaire-Rathdown, County Dublin, Leinster, A96-NW25, Ireland", longitude: 54.34, latitude: 0.243, clinic_link: "https://www.monicatolan.com", skin_clinic_availabilities_attributes: [ { day: "Monday - Friday", from: "10:00 AM", to: "06:00 PM" }, { day: "Saturday - Sunday", from: "10:00 AM", to: "04:00 PM" } ] } } }
		      	question_id = create(:question, accountable: admin, recommended: false).id
		        put :update, params: params
		        expect(response).to have_http_status(200)
		        expect(JSON.parse(response.body)['data']['attributes'].keys).to match_array(["id", "name", "location", "country", "latitude", "longitude", "created_at", "updated_at", "clinic_link", "availabilities"])
	      	end
	      	it 'Returns Error for not updating' do
		      	user = admin
		      	skin_clinic = create(:skin_clinic)
		      	id = skin_clinic.id
		      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
		      	params = { token: token, id: id, data: { attributes: { location: "Ark Vetcare, 33, Patrick Street, Dun Laoghaire-West Central ED, Dún Laoghaire, Dún Laoghaire-Rathdown, County Dublin, Leinster, A96-NW25, Ireland", longitude: 54.34, latitude: 0.243, clinic_link: "asdfghjhfdsaSDFGH", skin_clinic_availabilities_attributes: [ { day: "Monday - Friday", from: "10:00 AM", to: "06:00 PM" }, { day: "Saturday - Sunday", from: "10:00 AM", to: "04:00 PM" } ] } } }
		      	question_id = create(:question, accountable: admin, recommended: false).id
		        put :update, params: params
		        expect(response).to have_http_status(422)
		        expect(JSON.parse(response.body)['errors']['clinic_link']).to match_array(["Please enter valid url"])
	      	end
	    end
	end

	describe 'DELETE destroy ' do
	  	let(:admin) { create(:admin_user, :with_admin_role, freeze_account: false) }
	    before do
	     	@account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
	    end
		context "Only accessible to admin" do
			it 'Returns error' do
				token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
				delete :destroy, params: {token: token, id: 1234}
				expect(response). to have_http_status(422)
				expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
			end
	    end
	    context "When admin logged in" do
	    	it 'Returns success' do
		      	user = admin
		      	skin_clinic = create(:skin_clinic)
		      	id = skin_clinic.id
    			skin_clinic_availability = create(:skin_clinic_availability, skin_clinic: skin_clinic)
		      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
		      	params = { token: token, id: id, data: { attributes: { name: "TestClinicName", location: "Ark Vetcare, 33, Patrick Street, Dun Laoghaire-West Central ED, Dún Laoghaire, Dún Laoghaire-Rathdown, County Dublin, Leinster, A96-NW25, Ireland", longitude: 54.34, latitude: 0.243, clinic_link: "https://www.monicatolan.com", skin_clinic_availabilities_attributes: [ { day: "Monday - Friday", from: "10:00 AM", to: "06:00 PM" }, { day: "Saturday - Sunday", from: "10:00 AM", to: "04:00 PM" } ] } } }
		      	question_id = create(:question, accountable: admin, recommended: false).id
		        delete :destroy, params: params
		        expect(response).to have_http_status(200)
		        expect(JSON.parse(response.body)['message']).to eql("successfully deleted")
	      	end
	    end
	end

end
