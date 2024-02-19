require 'rails_helper'
RSpec.describe AccountBlock::AccountsController, type: :controller do
  
  let(:role) { FactoryBot.create(:role, name: "User") }
  let(:account) { FactoryBot.create(:email_account, :with_user_role) }
  let(:sms_account) { FactoryBot.create(:sms_account, :with_user_role) }
  let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) }
  let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) }
  let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) }
  let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) }
  let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }


  describe 'POST create' do
    before(:each) do
      @account = create(:account)
      email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image && role
    end


    context "when given correct credentials" do
      it 'Returns success' do
        post :create, params: { data: { type: "email_account" , attributes: { first_name: "name1", full_phone_number: "+919773454625", email: "test2@example.com", password: "test123", password_confirmation: "test123" , is_subscribed_to_mailing: true } } }
        expect(response).to have_http_status(201)
      end
    end

    context "when given invalid email" do
      it 'Returns Email invalid' do
        post :create, params: { data: { type: "email_account" , attributes: { first_name: "name1", full_phone_number: "+919778546878", email: "mandeeeeep", password: "test123", password_confirmation: "test123" , is_subscribed_to_mailing: true } } }
        expect(response).to have_http_status(422)
      end
    end

    context "when given incorrect phone number" do
      it 'Returns Full phone number Invalid or Unrecognized Phone Number' do
        post :create, params: { data: { type: "email_account" , attributes: { first_name: "name1", full_phone_number: "+919776878", email: "mandeeeeep@yopmail.com", password: "test123", password_confirmation: "test123" , is_subscribed_to_mailing: true } } }
        expect(response).to have_http_status(422)
      end
    end

    context "when given params email" do
      it 'Returns email is already use' do
        post :create, params: { data: { type: "email_account" , attributes: { first_name: "name1", full_phone_number: "+919778546878", email: "mandeeeeeemail.com", password: "test123", password_confirmation: "test123" , is_subscribed_to_mailing: true } } }
        expect(response).to have_http_status(422)
      end
    end

    context "when given password is not match" do
      it 'Returns password is not match' do
        post :create, params: { data: { type: "email_account" , attributes: { first_name: "name1", full_phone_number: "+919778546878", email: "test1@example.com", password: "test13", password_confirmation: "test123" , is_subscribed_to_mailing: true } } }
        expect(response).to have_http_status(422)
      end
    end

    context "when given account type social_account" do
      it 'Returns created' do
        post :create, params: { data: { type: "social_account" , attributes: { first_name: "name1", full_phone_number: "+919778546878", email: @account.email, password: "test123", password_confirmation: "test123" , is_subscribed_to_mailing: true } } }
        expect(response).to have_http_status(422)
        # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid Account Type")
      end
    end

    context "when given account is not match" do
      it 'Returns Invalid Account type' do
        post :create, params: { data: { type: "other_account" , attributes: { first_name: "name1", full_phone_number: "+919778546878", email: "test1@example.com", password: "test13", password_confirmation: "test123" , is_subscribed_to_mailing: true } } }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid Account Type")
      end
    end

    # describe 'create sms_account' do
    #   before do
    #     @account = create(:account, type: "InvitedAccount")
    #   end
    #   context "when given correct credentials" do
    #     it 'Returns success' do
    #       post :create, params: { token: @token, data: { type: "InvitedAccount" , attributes: { first_name: "name1", full_phone_number: "+919773454625", email: "test2@example.com", password: "test123", password_confirmation: "test123" , is_subscribed_to_mailing: true } } },as: :json
    #       expect(response).to have_http_status(422)
    #     end
    #   end
    # end
  end

  describe 'GET user_details' do
    before do
      @account = create(:account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
      context "when show user_details correct token" do
        it 'Returns success' do
        get :user_details, params: { use_route: "/accounts/" , token: @token, id: @account.id}
        expect(response).to have_http_status(200)
      end
    end

      context "when show user_details incorrect token" do
        it 'Returns Invalid token' do
        get :user_details, params: { use_route: "/accounts/" , token: @token1, id: @account.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
end


  describe 'GET show' do
    before do
      @account = create(:account)
    end
    context "when given registered email" do
      it 'Returns success' do
        get :show, params: { email: @account.email }
        expect(JSON.parse(response.body)).to eql({"account"=>"Account with #{@account.email} is registered"})
      end
    end
   
    context "when given not registered email" do
      it 'Returns This email is not registered on our system' do
        get :show, params: { email: "test111@example.com" }
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("This email is not registered on our system")
      end
    end
  end
  
  describe "PATCH update" do
    before do 
      @account = create(:account)
      jwt_token = SecureRandom.hex(4)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: jwt_token, account_type: @account.type}, 1.year.from_now)
      @account.update(jwt_token: jwt_token)
    end
  
    context "when update_password" do
      it "return You have successfully changed your password!" do
        patch :update, params:  { use_route: "/accounts/" , token: @token, account: { password: "testdemo123" , addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id }
        expect(response).to have_http_status(200)
        expect(@account.notifications.last.headings).to eql("Password changed")
      end
    end


    context "when update first_name" do
      it "return first_name update" do
        patch :update,params:{use_route: "/accounts", token: @token,  account: { first_name: "demo1",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
        account = JSON.parse(response.body)
        expect(account['data']['attributes']['first_name']).to eq "demo1"
      end
    end 

    context "when update last_name" do
      it "return last_name update" do
        patch :update,params:{use_route: "/accounts", token: @token,  account: { last_name: "demo2",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
        account = JSON.parse(response.body)
        expect(account['data']['attributes']['last_name']).to eq "demo2"
      end
    end

    context "when location is updated" do
      it "deletes all cart items" do
        cart_items = create(:cart_item, account_id: @account.id)
        patch :update,params:{use_route: "/accounts", token: @token,  account: { last_name: "demo2", location: "Ireland",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
        expect(@account.cart_items).to eq []
      end
    end 

    context "when update the gender" do
      it "return gender update" do
        patch :update, params:  { use_route: "/accounts/" , token: @token, account: { gender: "female",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id }
        account = JSON.parse(response.body)
        expect(account['data']['attributes']['gender']).to eq "female"
      end
    end

    context "when email is already in use" do
      it "return gender update" do
        create(:account, email: "invalid@example.com")
        patch :update, params:  { use_route: "/accounts/" , token: @token, account: { email: 'invalid@example.com', addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id }
        expect(response).to have_http_status(:unprocessable_entity)
        account = JSON.parse(response.body)
        expect(account['errors']['message']).to eq(["Email has already been taken"])
      end
    end

    # context "when update the profile pic" do
    #   it "return profile update" do
    #     patch :update, params:  { use_route: "/accounts/" , token: @token, account: { profile_pic: "spec/support/assets/1.jpeg",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
    #     expect(response).to have_http_status(200)
    #   end
    #    end

     context "when update email" do
          it "return update email" do
            patch :update,params:{use_route: "/accounts", token: @token,  account: { email: "new@example.com",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
            account = JSON.parse(response.body)
            expect(account['data']['attributes']['email']).to eq "new@example.com"
        end
      end

       context "when update full_phone_number" do
          it "return update full_phone_number" do
            patch :update,params:{use_route: "/accounts", token: @token,  account: { full_phone_number: "911234567899",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
            account = JSON.parse(response.body)
            expect(account['data']['attributes']['full_phone_number']).to eq "911234567899"
        end
      end 

       context "when update age" do
          it "return update age" do
            patch :update,params:{use_route: "/accounts", token: @token,  account: { age: "20",  addresses_attributes: [{country: "india", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
            account = JSON.parse(response.body)
            expect(account['data']['attributes']['age']).to eq 20
        end
      end 

       context "when update addresses_attributes" do
          it "return update addresses_attributes" do
            patch :update,params:{use_route: "/accounts", token: @token,  account: { addresses_attributes: [{country: "usa", city: "indore" , street: 'Home', postcode: 12345, address_type: "Home", county: "Indore"}] } , id: @account.id}
            account = JSON.parse(response.body)
            expect(account['data']['attributes']['addresses'][0]['country']).to eq "usa"
        end
      end 
    end
     
      

    describe "POST contact_us" do
      before do 
        @account = create(:account)
        jwt_token = SecureRandom.hex(4)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: jwt_token, account_type: @account.type}, 1.year.from_now)
        @account.update(jwt_token: jwt_token)
        email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image    
    end
    
    context "when contact_us mail send with token" do
      it "return mail send" do
      post :contact_us, params:  { use_route: "/accounts/" , token: @token , contact_us_primary_image: {  primary_image: "spec/support/assets/1.jpeg"  , message: "mmmrishabh" ,  email: "test1@example.com" , contact_us_secondary_image: { secondary_image: "spec/support/assets/1.jpeg"}  ,  subject: "sub test" } }
      expect(response).to have_http_status(200)
    end
      end

      context "when contact_us mail send without token" do
      it "return invalid token " do
      post :contact_us, params:  { use_route: "/accounts/" ,  contact_us_primary_image: {  primary_image: "spec/support/assets/1.jpeg"  , message: "mmmrishabh" ,  email: "test1@example.com" , contact_us_secondary_image: { secondary_image: "spec/support/assets/1.jpeg"}  ,  subject: "sub test" } }
      expect(response).to have_http_status(400)
    end
      end
      end


  describe 'PUT freeze_account' do
       before do
        @account = create(:account) 
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
         email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
      end
      context "when freeze_account" do
         it 'Returns You have successfully frozen your account' do
        put :freeze_account, params: { token: @token, id: @account.id}
         expect(JSON.parse(response.body)["message"]).to eql("Account frozen successfully.")
      end
       end

     context "when unfreeze_account" do
        it 'Returns Account unfrozen successfully' do
        put :unfreeze_account, params: { token: @token, id: @account.id}
         expect(JSON.parse(response.body)["message"]).to eql("Account unfrozen successfully.")

    end
      end
      end

  describe 'PUT renew_token' do
    before do
      @account = create(:account) 
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when renew_token" do
    it 'Returns success' do
      put :renew_token, params: { token: @token, id: @account.id}
      expect(response).to have_http_status(200)
      end
    end

    context "when renew_token invalid token" do
      it 'Returns Invalid token' do
        put :renew_token, params: { token: @token1, id: @account.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end

  describe 'PUT renew_token' do
    before do
      @account = create(:account) 
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end
    context "when renew_token" do
    it 'Returns success' do
      put :renew_token, params: { token: @token, id: @account.id}
      expect(response).to have_http_status(200)
      end
    end

    context "when renew_token invalid token" do
      it 'Returns Invalid token' do
        put :renew_token, params: { token: @token1, id: @account.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end


  describe 'DELETE logout' do
       before do
        @account = create(:account)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end
      context "when user logout" do
        it 'Returns User logged out successfully.' do
          delete :logout, params: {use_route: "/accounts/", token: @token , id: @account.id}
          expect(JSON.parse(response.body)["data"]["message"]).to eql("User logged out successfully.")
       end
         end
        context "when user logout wrong detail" do
        it 'Returns details does not belongs to this user' do
          delete :logout, params: {use_route: "/accounts", token: nil , id: @account.id}    
          expect(JSON.parse(response.body)).to eql( {"errors"=>{"message"=>"Invalid token", "token"=>"Invalid token"}})


       end
        end
        end

  describe 'DELETE destroy' do
        before do
        @account = create(:account) 
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
          email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
      end

      context "when destroy" do
         it 'Returns Email sent with delete confirmation link' do
          delete :destroy, params: { token: @token, id: @account.id}
        expect(JSON.parse(response.body)["message"]).to eql("Email sent with delete confirmation link")
      end
       end

      context "when destroy" do
         it 'Returns Invalid token' do
          delete :destroy, params: { token: nil, id: @account.id}
        expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
       end
       end

  describe 'PUT subscribe' do
      before do
        @account = create(:account)
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
      end
      context "when subscribe" do
        it 'Returns Subscribed successfully!' do
          put :subscribe, params: { token: @token, id: @account.id}
          expect(JSON.parse(response.body)["message"]).to eql("Subscribed successfully!")
        end
      end
      context "when subscribe" do
        it 'Returns Subscribed successfully!' do
          @klaviyo_list = create(:klaviyo_list, account: @account,  membership_list: 1)
          put :subscribe, params: { token: @token, id: @account.id}
          expect(JSON.parse(response.body)["message"]).to eql("Subscribed successfully!")
        end
      end

      context "when subscribe glow_getter user" do
       it 'Returns success' do
        @klaviyo_list = create(:klaviyo_list, account: @account,  membership_list: 2)
        put :subscribe, params: { token: @token, id: @account.id},as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
    context "when subscribe elite user" do
      it 'Returns success' do
        @klaviyo_list = create(:klaviyo_list, account: @account,  membership_list:3 )
        put :subscribe, params: { token: @token, id: @account.id},as: :json
        expect(response).to have_http_status(200)
        # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
  end


     describe 'DELETE unsubscribe' do
      before do
      @account = create(:account)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when unsubscribe" do
       it 'Returns Unsubscribed successfully!' do
        @klaviyo_list = create(:klaviyo_list, account: @account,  membership_list: 1)
        delete :unsubscribe, params: { token: @token, id: @account.id}
      expect(JSON.parse(response.body)["message"]).to eql("Unsubscribed successfully!")
    end
  end

     context "when unsubscribe with free" do
      it 'Returns Unsubscribed successfully!' do
        @klaviyo_list = create(:klaviyo_list, account: @account,  membership_list: 2)
        put :unsubscribe, params: {token: @token, id: @account.id}
        expect(JSON.parse(response.body)["message"]).to eql("Unsubscribed successfully!")
        # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end

  context "when unsubscribe glow_getter" do
      it 'Returns Unsubscribed successfully!' do
        @klaviyo_list = create(:klaviyo_list, account: @account,  membership_list: 3)
        put :unsubscribe, params: {token: @token, id: @account.id}
        expect(JSON.parse(response.body)["message"]).to eql("Unsubscribed successfully!")
        # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end

  context "when unsubscribe elite" do
      it 'Returns Unsubscribed successfully!' do
        @klaviyo_list = create(:klaviyo_list, account: @account,  membership_list: 4)
        put :unsubscribe, params: {token: @token, id: @account.id}
        expect(JSON.parse(response.body)["message"]).to eql("Unsubscribed successfully!")
        # expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
      end
    end
end

     describe 'GET skin_journey/:skin_journey_id' do
      before do
      @account = create(:account)
      create(:skin_journey, :with_therapist, account_id: @account.id)
      @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    end

    context "when skin_journey create" do
     it 'Returns create' do
        get :skin_journey, params: { token: @token, id: @account.id, skin_journey_id: 1 }
        expect(response).to have_http_status(200)
      end
    end
     end

    describe 'PUT add_sign_in_time' do
        before do
        @account = create(:account) 
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end

      context "when add_sign_in_time" do
        it 'Returns Sign in added' do
            put :add_sign_in_time, params: { use_route: "/accounts",token: @token, id: @account.id }
            expect(JSON.parse(response.body)["message"]).to eql("Sign in added.")
          end
        end
         end

    describe 'PUT add_sign_out_time' do
        before do
        @account = create(:account) 
        @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        end

      context "when add_sign_out_time" do
        it 'Returns add_sign_out_time.' do
            put :add_sign_out_time, params: { use_route: "/accounts",token: @token, id: @account.id }
            expect(JSON.parse(response.body)["message"]).to eql("Sign out added.")
          end
        end

      context "when add_sign_out_time in invalid token" do
        it 'Returns Invalid token.' do
            put :add_sign_out_time, params: { use_route: "/accounts",token: nil, id: @account.id }
            expect(JSON.parse(response.body)["errors"]["message"]).to eql("Invalid token")
          end
        end
         end
end
