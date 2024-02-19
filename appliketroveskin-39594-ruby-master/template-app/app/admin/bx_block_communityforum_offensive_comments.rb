
ActiveAdmin.register BxBlockCommunityforum::Comment, as: "Offensive Comments" do

    menu label: 'Offensive Comments'
    menu :parent => "User Moderation Panel", :priority => 3
    permit_params :offensive

    actions :all, :except => [:new, :destroy]

    controller do
        def scoped_collection
          super.offensive
        end
        def update
          comment = BxBlockCommunityforum::Comment.update(params[:id], offensive: params[:bx_block_communityforum_comment][:offensive])
          question = BxBlockCommunityforum::Question.find(comment.objectable_id)
          if comment.present? && params[:bx_block_communityforum_comment][:offensive] == "false"
            payload_data = {account: comment.accountable, notification_key: 'post_approved', inapp: true, push_notification: true, type: 'skin_hub', redirect: 'view_comment', key: "forum"}
            BxBlockPushNotifications::FcmSendNotification.new("Your comment on #{question.title} has been approved.", "Comment approved", comment.accountable.device_token, payload_data).call if comment.description.present?
          end
        end
    end

    index do
      selectable_column
      column :id
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
  
