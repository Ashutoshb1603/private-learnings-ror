require 'rails_helper'

RSpec.describe BxBlockPushNotifications::PushNotificationsController, type: :controller do
    let(:user) { AccountBlock::Account.create!(full_name: "aaa", email: "aaa@gmail.com", password: "Admin@1234", user_name: "dfdfdsfs", activated: true) }
    let(:token) {BuilderJsonWebToken.encode(user.id, 10.minutes.from_now, token_type: 'login')}
    let(:push_notification) {BxBlockPushNotifications::PushNotification.create(push_notificable: user, remarks: "test")}
    let(:club_push_notification) {BxBlockPushNotifications::PushNotification.create(push_notificable: user, remarks: "test", notify_type: 'social_club')}
    let(:hidden_place_push_notification) {BxBlockPushNotifications::PushNotification.create(push_notificable: user, remarks: "test", notify_type: 'social_club')}

    describe "Create a push notification" do
        context "push notification" do
            it "should create a new push notification" do
                expect {
                    @request.headers[:token] =  token
                    push_notification
                }.to change {BxBlockPushNotifications::PushNotification.count}
            end

            it "should create new social club push notification" do
                @request.headers[:token] =  token
                expect {
                    club_push_notification
                }.to change {BxBlockPushNotifications::PushNotification.count}

                expect(club_push_notification).not_to be_nil
            end

            it "should create new hidden place push notification" do
                @request.headers[:token] =  token
                expect {
                    hidden_place_push_notification
                }.to change {BxBlockPushNotifications::PushNotification.count}
                
                expect(hidden_place_push_notification).not_to be_nil
            end

            it "should create new club event push notification" do
                @request.headers[:token] =  token
                expect {
                    BxBlockPushNotifications::PushNotification.create(push_notificable: user, remarks: "test", notify_type: 'club_event')
                }.to change {BxBlockPushNotifications::PushNotification.count}
            end

            it "should create new travel item push notification" do
                @request.headers[:token] =  token
                expect {
                    BxBlockPushNotifications::PushNotification.create(push_notificable: user, remarks: "test", notify_type: 'travel_item')
                }.to change {BxBlockPushNotifications::PushNotification.count}
            end

            it "should create new weather push notification" do
                @request.headers[:token] =  token
                expect {
                    BxBlockPushNotifications::PushNotification.create(push_notificable: user, remarks: "test", notify_type: 'weather')
                }.to change {BxBlockPushNotifications::PushNotification.count}
            end
        end
    end

    describe "Index" do
        context "This should return all push notification" do
            it "should returns all push notifications" do
                @request.headers[:token] =  token
                push_notification
                get :index, params: {today: "true"}
                expect(response).to have_http_status(:ok)
                expect(JSON.parse(response.body).size).to eq(1)       
            end
        end
    end

    describe "Update" do
        context "This should update notifications read or unread" do
            it "should mark push notification read" do
                @request.headers[:token] =  token
                push_notification
                put :mark_read, params: {all: "true"}
                expect(response).to have_http_status(:ok)
                expect(BxBlockPushNotifications::PushNotification.last&.is_read).to eq(true)   
            end

            it "should mark push notification unread" do
                @request.headers[:token] =  token
                push_notification
                put :mark_unread, params: {all: "true"}
                expect(response).to have_http_status(:ok)
                expect(BxBlockPushNotifications::PushNotification.last&.is_read).to eq(false)   
            end
        end
    end

	describe "Unread notification check" do
		context "check if user have unread notification" do
			it "should return true if user have unread notification" do
				@request.headers[:token] =  token
				push_notification
				get :any_unread_msg
				expect(response).to have_http_status(:ok)
				expect(JSON.parse(response.body)["unread_notification_present"]).to eq(true)
			end
		end
	end
end
