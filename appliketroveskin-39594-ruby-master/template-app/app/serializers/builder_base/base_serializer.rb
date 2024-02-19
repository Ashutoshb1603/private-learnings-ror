module BuilderBase
  class BaseSerializer
    include FastJsonapi::ObjectSerializer

    class << self
      private

      def base_url
        Rails.env.production? ? ENV['BASE_URL'] : 'http://localhost:3000'
      end

      def get_image_url(object, is_glow_getter = false)
        class_name =  object.class.name.split("::").last
        case class_name
        when "EmailAccount"
          object&.profile_pic&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.profile_pic, only_path: true) : nil
        when "AdminUser"
          object&.profile_pic&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.profile_pic, only_path: true) : nil
        when "DynamicImage"
          image = is_glow_getter && object&.glow_getter_image.attached? ? object.glow_getter_image : object&.image
          image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) : nil
        else
          class_name != "AdminUser" && object&.image&.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true) : nil
        end
      end

      def get_video_url(object)
        object.video.attached? ? base_url + Rails.application.routes.url_helpers.rails_blob_url(object.video, only_path: true) : nil
      end

      def get_videos_url(object)
        videos = []
        if object.videos.attached?
          videos = object.videos.map {|video| base_url + Rails.application.routes.url_helpers.rails_blob_url(video, only_path: true)}
        end
        videos
      end
      
    end
  end
end
