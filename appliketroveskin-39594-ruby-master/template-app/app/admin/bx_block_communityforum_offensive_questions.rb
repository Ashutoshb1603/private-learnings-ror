
ActiveAdmin.register BxBlockCommunityforum::Question, as: "Offensive Questions" do

    menu label: 'Offensive Questions'
    menu :parent => "User Moderation Panel", :priority => 2
    permit_params :offensive

    actions :all, :except => [:new, :destroy]

    controller do
        def scoped_collection
          super.offensive
        end
        def update
          question = BxBlockCommunityforum::Question.update(params[:id], offensive: params[:bx_block_communityforum_question][:offensive])
          if question.present? && params[:bx_block_communityforum_question][:offensive] == "false"
            payload_data = {account: question.account, notification_key: 'post_approved', inapp: true, push_notification: false, type: 'skin_hub', redirect: 'forum_view_post', key: "forum"}
            BxBlockPushNotifications::FcmSendNotification.new("Your post on #{question.description} has been approved", "Post approved", question.account.device_token, payload_data).call if question.title.present?
          end
        end
    end

    index do
      selectable_column
      column :id
      column :title
      column :description
      column "Name" do |object|
        object.accountable.name
      end
      column :created_at do |object| 
        object.created_at.strftime("%d %B %Y %H:%M")
      end
      toggle_bool_column :offensive
    end
  
  end
  
