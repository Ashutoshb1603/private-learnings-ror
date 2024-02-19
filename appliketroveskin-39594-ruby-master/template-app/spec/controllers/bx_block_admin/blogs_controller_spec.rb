require 'rails_helper'
RSpec.describe BxBlockAdmin::BlogsController, type: :controller do
  let(:email_cover_image) { create(:dynamic_image, image_type: "email_cover" ) }
  let(:email_logo_image) { create(:dynamic_image, image_type: "email_logo" ) }
  let(:email_tnc_icon_image) { create(:dynamic_image, image_type: "email_tnc_icon" ) }
  let(:policy_icon_image) { create(:dynamic_image, image_type: "policy_icon" ) }
  let(:email_profile_icon_image) { create(:dynamic_image, image_type: "email_profile_icon" ) }

  describe 'POST create' do
  	let(:admin) { create(:admin, freeze_account: false) }

    before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
      @therapist = create(:email_account, :with_therapist_role, freeze_account: false)
      @recommended_product = create(:recommended_product, account: @account, parentable: @therapist, product_id: "7549057564891", title: "Youth EssentiA Vita-Peptide Toner", price: "46.00")
      create(:purchase, recommended_product: @recommended_product, quantity:  1)
      create(:membership_plan, account: @account, plan_type: "glow_getter", end_date: 1.month.after)
      email_cover_image && email_logo_image && email_tnc_icon_image && policy_icon_image && email_profile_icon_image
    end
    context "when we pass glow_getter plan_type" do
      it 'Returns success' do
      	user = admin
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        post :create, params: {token: token, blog_id: "79521054902", data: { article: { title: "from api 2", body_html: "this is some test body html", tags: "", image: { src: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/ba/29/5c/img-worlds-of-adventure.jpg?w=1200&h=-1&s=1", alt: "Rails logo" } } } },as: :json
        expect(response). to have_http_status(200)
      end
    end
	# context "Only accessible to admin" do
 #      it 'Returns success' do
 #      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
 #        post :create, params: {token: token, data: { article: { title: "from api 2", body_html: "this is some test body html", tags: "", image: { src: "http://example.com/rails_logo.gif", alt: "Rails logo" } } } }
 #        expect(response). to have_http_status(422)
 #        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
 #      end
 #    end
  end

  describe 'post pin_or_unpin' do
  	let(:admin) { create(:admin, freeze_account: false) }
  	before do
      @account = create(:account, :with_user_role, freeze_account: false, location: "United Kingdom")
      @therapist = create(:email_account, :with_therapist_role, freeze_account: false)
      @recommended_product = create(:recommended_product, account: @account, parentable: @therapist, product_id: "7549057564891", title: "Youth EssentiA Vita-Peptide Toner", price: "46.00")
      create(:purchase, recommended_product: @recommended_product, quantity:  1)
      create(:membership_plan, account: @account, plan_type: "glow_getter", end_date: 1.month.after)
    end
    context "Only accessible to admin" do
      it 'Returns success' do
      	token = BuilderJsonWebToken.encode(@account.id, {jwt_token: @account.jwt_token, account_type: @account.type}, 1.year.from_now)
        post :create, params: {token: token, data: { article: { title: "from api 2", body_html: "this is some test body html", tags: "", image: { src: "http://example.com/rails_logo.gif", alt: "Rails logo" } } } }
        expect(response). to have_http_status(422)
        expect(JSON.parse(response.body)['errors']['message']).to eql("You are not authorized to view this section.")
      end
    end
    context "when admin logged in" do
      it 'Returns success' do
      	user = admin
      	token = BuilderJsonWebToken.encode(user.id, {jwt_token: user.jwt_token, account_type: user.type}, 1.year.from_now)
        post :pin_or_unpin, params: {token: token, article_id: "557643169974" }
        expect(response). to have_http_status(200)
        expect(JSON.parse(response.body)['message']).to eql("Pinned successfully")
      end
    end
  end
end
