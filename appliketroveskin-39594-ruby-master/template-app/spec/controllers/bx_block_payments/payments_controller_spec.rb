require 'rails_helper'
RSpec.describe BxBlockPayments::PaymentsController, type: :controller do
  let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) }
  let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) }
  let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) }
  let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) }
  let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }
  let(:therapist) { create(:account, :with_therapist_role , freeze_account: false) }
  let(:acuity) { BxBlockAppointmentManagement::AcuityController.new }
  let(:appointment_types) { acuity.appointment_types }
  let(:calendar_id) { appointment_types&.first['calendarIDs'].first }
  let(:appointmentTypeID) { appointment_types&.first['id'] }
  let(:available_dates) { acuity.available_dates(calendar_id, appointmentTypeID, Time.now.strftime("%Y-%m")) }
  let(:available_time) { acuity.available_times(calendar_id, appointmentTypeID, available_dates.first['date']) }


describe 'PUT upgrade_user' do
  before do
    @account = create(:account , freeze_account: false)
    @payment = create(:payment, account: @account)
    @wallet = create(:wallet, account: @account)
    @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
    @plan = create(:plan)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
  end

  context "when pass correct params" do
    it 'Returns success' do
    put :upgrade_user, params: { use_route: "/payments/" , token: @token, data: { attributes: { receipt_id: "TESTRECEIPT", plan_id: @plan.id } } }
    expect(response).to have_http_status(200)
    end
  end

  context "when pass incorrect params" do
    it 'Returns Plan not found' do
    put :upgrade_user, params: { use_route: "/payments/" , token: @token, data: { attributes: { receipt_id: "TESTRECEIPT", plan_id: 1111111111 } } }
    expect(JSON.parse(response.body)['message']).to eql("Plan not found")
    expect(response).to have_http_status(404)
    end
  end
end


describe 'GET my_wallet' do
  before do
    @account = create(:account , freeze_account: false)
    @payment = create(:payment, account: @account)
    @wallet = create(:wallet, account: @account)
    @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
    @plan = create(:plan)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
    get :my_wallet, params: { use_route: "/payments/" , token: @token }
    expect(response).to have_http_status(200)
    end
  end
end

describe 'POST membership_update' do
  before do
    @account = create(:account , freeze_account: false)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
      post :membership_update, params: { use_route: "/payments/" , token: @token, user_id: @account.id }
      expect(response).to have_http_status(200)
    end
  end
  context "when membership already exists" do
    it 'Returns success' do
      create(:membership_plan, account: @account, end_date: 1.day.after, updated_at: 26.day.before)
      post :membership_update, params: { use_route: "/payments/" , token: @token, user_id: @account.id }
      expect(response).to have_http_status(200)
    end
  end
end

describe 'PUT add_money' do
  before do
    email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
    @account = create(:account , freeze_account: false)
    @address = create(:address, addressable: @account)
    @payment = create(:payment, account: @account)
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @card = Stripe::Token.create({card: {number: '4242424242424242',exp_month: 10,exp_year: 2034,cvc: '123',},})
    stripe_customer = Stripe::Customer.create({email: @account.email, source: @card['id'],})
    @account.update(stripe_customer_id: stripe_customer.id)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
    put :add_money, params: { use_route: "/payments/" , token: @token, amount: 100, payment:{ payment_gateway: "stripe", currency: 'eur', token: @card['card']['id'] } },as: :json
    expect(response).to have_http_status(200)
    end
  end
end

describe 'POST pay_with_card' do
  before do
    email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
    @account = create(:account , freeze_account: false)
    @address = create(:address, addressable: @account)
    create(:wallet, account: @account)
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @card = Stripe::Token.create({card: {number: '4242424242424242',exp_month: 10,exp_year: 2034,cvc: '123',},})
    stripe_customer = Stripe::Customer.create({email: @account.email, source: @card['id'],})
    @account.update(stripe_customer_id: stripe_customer.id)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
    post :pay_with_card, params: { use_route: "/payments/" , token: @token, payment:{ payment_gateway: "stripe", amount: 100, currency: 'eur', card_id: @card['card']['id'], description: "wallet top up" } },as: :json
    expect(response).to have_http_status(200)
    end
  end
end

describe 'GET list_card' do
  before do
    email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
    @account = create(:account , freeze_account: false)
    @address = create(:address, addressable: @account)
    create(:wallet, account: @account)
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @card = Stripe::Token.create({card: {number: '4242424242424242',exp_month: 10,exp_year: 2034,cvc: '123',},})
    stripe_customer = Stripe::Customer.create({email: @account.email, source: @card['id'],})
    @account.update(stripe_customer_id: stripe_customer.id)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
      get :list_cards, params: { use_route: "/payments/" , token: @token },as: :json
      expect(response).to have_http_status(200)
    end
    it 'Returns success' do
      @account.update(stripe_customer_id: nil)
      get :list_cards, params: { use_route: "/payments/" , token: @token },as: :json
      expect(response).to have_http_status(404)
    end
  end
end


describe 'PUT use_money' do
  before do
    @account = create(:account , freeze_account: false)
    @payment = create(:payment, account: @account)
    @wallet = create(:wallet, account: @account)
    @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
    put :use_money, params: { use_route: "/payments/" , token: @token }
    expect(response).to have_http_status(200)
    end
  end
end

describe 'POST send_gift' do
  before do
    email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
    @account = create(:account , freeze_account: false)
    @payment = create(:payment, account: @account)
    @wallet = create(:wallet, account: @account, balance: 777.00)
    @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
    @gift_type = create(:gift_type)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass incorrect params" do
    it 'Returns success' do
      receiver = create(:account)
      create(:wallet, account: receiver)
      post :send_gift, params: { use_route: "/payments/" , token: @token, data: { attributes: { email_id: receiver.email, amount: 20, custom_message: "Some custome message", gift_type_id: @gift_type.id } } }, as: :json
      expect(response).to have_http_status(200)
    end
    it 'Returns error for same email' do
      post :send_gift, params: { use_route: "/payments/" , token: @token, data: { attributes: { email_id: "notexist.com", amount: 20, custom_message: "Some custome message", gift_type_id: @gift_type.id } } }, as: :json
      expect(response).to have_http_status(422)
    end
    it 'Returns error for same email' do
      post :send_gift, params: { use_route: "/payments/" , token: @token, data: { attributes: { email_id: @account.email, amount: 20, custom_message: "Some custome message", gift_type_id: @gift_type.id } } }, as: :json
      expect(response).to have_http_status(422)
    end
    it 'Returns success' do
      receiver = create(:account)
      create(:wallet, account: receiver, currency: 'gbp')
      post :send_gift, params: { use_route: "/payments/" , token: @token, data: { attributes: { email_id: receiver.email, amount: 20, custom_message: "Some custome message", gift_type_id: @gift_type.id } } }, as: :json
      expect(response).to have_http_status(422)
    end
    it 'Returns success' do
      receiver = create(:account)
      create(:wallet, account: receiver)
      post :send_gift, params: { use_route: "/payments/" , token: @token, data: { attributes: { email_id: receiver.email, amount: 2000000000, custom_message: "Some custome message", gift_type_id: @gift_type.id } } }, as: :json
      expect(response).to have_http_status(422)
    end
  end
end

describe 'GET thank_you' do
  before do
    @account = create(:account , freeze_account: false)
    @payment = create(:payment, account: @account)
    @wallet = create(:wallet, account: @account)
    @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass correct params" do
    it 'Returns success' do
    get :thank_you, params: { use_route: "/payments/" , token: @token, email: @account.email, amount: 123.00 }
    expect(response).to have_http_status(200)
    end
  end
end

describe 'GET get_wallet_transaction' do
  before do
    @account = create(:account , freeze_account: false)
    @payment = create(:payment, account: @account)
    @wallet = create(:wallet, account: @account)
    @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
    @gift_type = create(:gift_type)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass incorrect params" do
    it 'Returns success' do
    get :get_wallet_transaction, params: { use_route: "/payments/" , token: @token, id: @wallet_transaction.id }
    expect(response).to have_http_status(200)
    end
  end
end

describe 'POST submit' do
  before do
    @account = create(:account , freeze_account: false)
    @address = create(:address, addressable: @account)
    @appointment = create(:appointment, account: @account)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
    @cart_item = create(:cart_item, variant_id: "42503800651995", product_id:"7549054517467", quantity: 1, price: 14.00, name: "Aubergine Lip Pencil", product_image_url: "https://cdn.shopify.com/s/files/1/0620/5046/8059/products/auberginepencil.jpg?v=1645521708", account: @account)
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    @card = Stripe::Token.create({card: {number: '4242424242424242',exp_month: 10,exp_year: 2034,cvc: '123',},})
    stripe_customer = Stripe::Customer.create({email: @account.email, source: @card['id'],})
    @account.update(stripe_customer_id: stripe_customer.id)
  end

  context "when pass payment gateway stripe" do
    it 'Returns success' do
      order_params = { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: true, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1" }
      post :submit, params: { use_route: "/payments/" , token: @token, payment: { payment_gateway: "stripe", token: @card['card']['id'], currency: 'gbp' }, amount: 0.5e1, order: order_params }, as: :json
      expect(response).to have_http_status(0)
    end
  end

  context "when pass payment gateway stripe" do
    it 'Returns success' do
      create(:wallet, account: @account, balance: 3456.00)
      order_params = { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: true, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1" }
      post :submit, params: { use_route: "/payments/" , token: @token, payment: { payment_gateway: "wallet", token: @card['card']['id'], currency: 'eur' }, amount: 35.5, order: order_params }, as: :json
      expect(response).to have_http_status(0)
    end
  end

  context "when pass payment gateway paypal" do
    it 'Returns success' do
      create(:wallet, account: @account, balance: 3456.00, currency: 'gbp')
      order_params = { email: @account.email, phone: "+919773454625", address_id: @address.id, requires_shipping: true, cart_item_ids: [@cart_item.id], transaction_id: "TRANSACTION1" }
      post :submit, params: { use_route: "/payments/" , token: @token, payment: { payment_gateway: "paypal", token: @card['card']['id'], currency: 'eur' }, amount: 35.5, order: order_params }, as: :json
      expect(response).to have_http_status(200)
    end
  end

  context "when pass payment gateway stripe" do
    it 'Returns success' do
      appointment_params = { data: {datetime: available_time.first['time'], appointmentTypeID: appointmentTypeID, calendarID: calendar_id, firstName: "Test", lastName: "Name", phone: "9999999999", address: "full address", age: 23, email: "test@email.com" } }
      post :submit, params: { use_route: "/payments/" , token: @token, payment: { payment_gateway: "stripe", token: @card['card']['id'], currency: 'eur' }, amount: 35.5, appointment: appointment_params }, as: :json
      expect(response).to have_http_status(0)
    end
  end
end

describe 'GET PLANS' do
  before do
    @account = create(:account , freeze_account: false)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end

  context "when pass incorrect params" do
    it 'Returns success' do
      create(:plan)
      get :plans, params: { use_route: "/payments/" , token: @token }
      expect(response).to have_http_status(200)
    end
  end
end

# describe 'GET execute' do
#   before do
#     @account = create(:account , freeze_account: false)
#     @payment = create(:payment, account: @account, status: 2)
#     @wallet = create(:wallet, account: @account)
#     @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
#     @gift_type = create(:gift_type)
#     byebug
#     @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
#   end
#   context "when pass incorrect params" do
#     it 'Returns success' do
#       create(:plan)
#       get :execute, params: { use_route: "/payments/" , token: @token, paymentId: @payment.id ,PayerID: 1  },as: :json
#       byebug
#       expect(response).to have_http_status(200)
#     end
#   end
# end

describe 'GET cancel' do
  before do
    @account = create(:account , freeze_account: false)
    @payment = create(:payment, account: @account, status: 2)
    @wallet = create(:wallet, account: @account)
    @wallet_transaction = create(:wallet_transaction, wallet: @wallet)
    @gift_type = create(:gift_type)
    @token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
  end
  context "when pass correct params" do
    it 'Returns success' do
      get :cancel, params: { use_route: "/payments/" , token: @token},as: :json
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['message']).to eql("Payment cancelled!")
    end
  end
end
end
