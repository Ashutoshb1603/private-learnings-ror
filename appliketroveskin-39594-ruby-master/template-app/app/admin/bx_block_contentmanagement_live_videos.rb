
ActiveAdmin.register BxBlockContentmanagement::LiveVideo, as: "Live Videos" do

    permit_params :title, :description, :group_id, :status, :image
    menu :parent => "Skin Hub", :priority => 2
    actions :all, :except => [:show, :new]

    controller do 
      before_action :fetch_and_add_videos, only: :index

      def fetch_and_add_videos
        twilio_client = BxBlockLivestreaming::TwilioController.new
        live_videos = BxBlockContentmanagement::LiveVideo.processing

        live_videos.each do |live_video|
          composition_sid = live_video.composition_sid
          if composition_sid.present? and !live_video.videos.attached?
            twilio_client.create_composed_media(live_video)
          elsif live_video.room_sid.present? and !live_video.videos.attached?
            twilio_client.create_composition(live_video.room_sid)
          end
        end
      end
    end

    index do
      selectable_column 
      column :title
      column :description
      column :group
      column "Thumbnail" do |im|
        image_tag im.image, size: 100 if im.image.attached?
      end
      column :url do |object|
        object.videos.attached? ? (render "live_video", locals: {url: ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_url(object.videos.first, only_path: true)}) : "Video Processing"
      end
      actions
    end
  
    form do |f|
      f.inputs 'LiveVideo' do 
       f.input :title
       f.input :description
       f.input :group
       f.input :image, label: "Thumbnail", as: :file
       f.input :status
      end
      actions
    end

end
  
