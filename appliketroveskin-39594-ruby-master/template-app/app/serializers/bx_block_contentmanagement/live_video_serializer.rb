module BxBlockContentmanagement
    class LiveVideoSerializer < BuilderBase::BaseSerializer
      @@time_helper = Helpers::TimeHelper.new
      attributes :id, :title, :description, :url, :group, :created_at, :posted_at, :likes, :views, :is_liked, :videos, :thumbnail

      attribute :group do |object|
        object&.group&.title
      end

      attribute :likes do |object|
        object.video_likes.count
      end

      attribute :views do |object|
        object.video_views.count
      end

      attribute :is_liked do |object, params|
        object.video_likes.where(account_id: params[:current_user].id).present?
      end

      attribute :posted_at do |object|
        @@time_helper.format_time_in_ago(object.created_at)
      end

      attribute :videos do |object|
        get_videos_url(object)
      end

      attribute :thumbnail do |object|
        get_image_url(object)
      end

    end
  end
  