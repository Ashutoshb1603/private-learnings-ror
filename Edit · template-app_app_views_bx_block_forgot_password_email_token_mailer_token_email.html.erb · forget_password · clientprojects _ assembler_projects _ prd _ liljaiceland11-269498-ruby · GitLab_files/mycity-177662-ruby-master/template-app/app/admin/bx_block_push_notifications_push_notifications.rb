ActiveAdmin.register BxBlockPushNotifications::PushNotification, as: "PushNotification" do
    actions :all, :except => [:new, :destroy, :edit]
    # index do
    # end
end