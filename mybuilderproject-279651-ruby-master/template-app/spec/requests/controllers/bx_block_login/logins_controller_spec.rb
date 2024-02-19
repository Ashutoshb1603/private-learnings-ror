require 'rails_helper'

describe BxBlockLogin::LoginsController, :type => :controller do
  before(:all) do 
    # @token = SecureRandom.base64.tr('+/=', 'Qrt')
    @account = FactoryBot.create(:account)
  end

  describe "/bx_block_login/logins" do
    context "with valid attributes of operator" do
      let(:valid_otp_param) do
        { data: {
            attributes: {
              email:@account.email
            },
            type: "email_account",
            user_type: "operator"
          }
        }
      end
      it "operator should sign up with email" do
        post :create, params: valid_otp_param
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes of operator" do
      let(:invalid_otp_param) do
        { data: {
            attributes: {
              email:'abc@gmail.com'
            },
            type: "email_account",
            user_type: "operator"
          }
        }
      end
      it "operator should not sign up with email" do
        post :create, params: invalid_otp_param
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid attributes of operator" do
      let(:invalid_otp_param) do
        { data: {
            attributes: {
              email:'abc@gmail.com'
            },
            type: "sms_account",
            user_type: "operator"
          }
        }
      end
      it "operator should not sign up with email as it is invalid account type " do
        post :create, params: invalid_otp_param
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with valid attribute of charterer" do
      let(:valid_otp_param) do
        { data: {
            attributes: {
              email:@account.email
            },
            type: "email_account",
            user_type: "charterer"
          }
        }
      end
      it "charterer should sign up with enail" do
        post :create, params: valid_otp_param
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes of charterer" do
      let(:invalid_otp_param) do
        { data: {
            attributes: {
              email:'abc@gmail.com'
            },
            type: "email_account",
            user_type: "charterer"
          }
        }
      end
      it "charterer should not sign up with email" do
        post :create, params: invalid_otp_param
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    # context "with valid attribute of charterer" do
    #   let(:valid_otp_param) do
    #     { data: {
    #         attributes: {
    #           full_phone_number: @account.full_phone_number
    #         },
    #         type: "sms_account",
    #         user_type: "charterer"
    #       }
    #     }
    #   end
    #   it "charterer should sign up with phone number" do
    #     post :create, params: valid_otp_param
    #     expect(response).to have_http_status(:created)
    #   end
    # end

    context "with invalid attributes of charterer" do
      let(:invalid_otp_param) do
        { data: {
            attributes: {
              full_phone_number:'911111111111'
            },
            type: "sms_account",
            user_type: "charterer"
          }
        }
      end
      it "charterer should not sign up with phone number" do
        post :create, params: invalid_otp_param
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid attributes of charterer" do
      let(:invalid_otp_param) do
        { data: {
            attributes: {
              email:'abc@gmail.com'
            },
            type: "abc_account",
            user_type: "charterer"
          }
        }
      end
      it "charterer should not sign up with email as it is invalid account type " do
        post :create, params: invalid_otp_param
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with invalid attribute" do
      let(:invalid_otp_param) do
        { data: {
            attributes: {
              email:"qwerty.com"
            },
            type: "email_account"
          }
        }
      end
      it "should  sign up " do
        post :create, params: invalid_otp_param
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end