
ActiveAdmin.register BxBlockContentmanagement::Tutorial, as: "Tutorial" do

    permit_params :title, :description, :url, :group_id
    menu :parent => "Skin Hub", :priority => 1
    actions :all, :except => [:show]
    index do
      selectable_column 
      column :title
      column :description
      column :group
      column :url do |object|
        # <iframe class="responsive-iframe" src="https://www.youtube.com/embed/oOeyHrIlc9M" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" title="AndyReloads - Assassin's Creed Valhalla Content Creator" allowfullscreen></iframe>
        render "video_tutorial", locals: {url: object.url}
      end
      actions
    end
  
    form do |f|
      f.inputs 'Tutorial'do 
       f.input :title
       f.input :description
       f.input :group
       f.input :url
      end
      actions
    end

    controller do
      def create
        tutorial = BxBlockContentmanagement::Tutorial.create(tutorial_params)
        if tutorial
          accounts = AccountBlock::Account.where("device_token is not null and device_token != ''")
          registration_ids = accounts.map(&:device_token)
          payload_data = {account_ids: accounts.map(&:id), notification_key: 'open_tutorial', inapp: true, push_notification: true, all: true, type: 'skin_hub', redirect: 'open_tutorial', record_id: tutorial.id, notification_for: 'tutorial', key: "tutorial"}
          BxBlockPushNotifications::FcmSendNotification.new("A new video tutorial, #{tutorial_params[:title]} has been uploaded", "New tutorial uploaded", registration_ids, payload_data).call if tutorial_params[:title].present?

          redirect_to admin_tutorials_path
        end
      end
      protected

      def tutorial_params
        params.require(:bx_block_contentmanagement_tutorial).permit(:title, :description, :group_id, :url)
      end
    end
end
  
