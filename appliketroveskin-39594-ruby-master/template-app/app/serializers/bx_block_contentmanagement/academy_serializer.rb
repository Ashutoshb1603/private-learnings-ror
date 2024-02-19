module BxBlockContentmanagement
    class AcademySerializer < BuilderBase::BaseSerializer

      attributes :id, :title, :description, :key_points, :price, :is_unlocked, :academy_videos

      attribute :price do |object, params|
        user = params[:current_user]
        user.location.downcase == "ireland" ? object.price : object.price_in_pounds
      end

      attribute :price_in_euro do |object|
        object.price
      end

      attribute :price_in_pounds do |object|
        object.price_in_pounds
      end
      
      attributes :key_points do |object|
        object.key_points&.select(:id, :description)
      end

      attribute :is_unlocked do |object, params|
        params[:current_user].type == "AdminAccount" ? true : params[:current_user].customer_academy_subscriptions.where(academy_id: object.id).present?
      end

      attribute :academy_videos do |object, params|
            # is_unlocked = params[:current_user].type == "AdminAccount" ? true : params[:current_user].customer_academy_subscriptions.where(academy_id: object.id).present?
            # is_unlocked ? AcademyVideosSerializer.new(object.academy_videos).serializable_hash : {data: []}
          AcademyVideosSerializer.new(object.academy_videos).serializable_hash
      end

      attribute :currency do |object, params|
        user = params[:current_user]
        user.location.downcase == "ireland" ? "EUR" : "GBP"
      end

      attribute :cover_image do |object|
        image = object.image.attached? ? get_image_url(object) : nil
      end

      attribute :video_count do |object|
        object.academy_videos.count
      end
  end
end
  