module BxBlockCommunityforum
    class CommentsSerializer < BuilderBase::BaseSerializer
      attributes :id, :description, :image, :user, :created_at, :posted_at, :likes, :replies, :is_liked, :offensive
      @@time_helper = Helpers::TimeHelper.new

      attribute :user do |object|
        user = {
            name: object.accountable&.name,
            id: object.accountable&.id,
            profile_image: get_image_url(object.accountable),
            user_type: object&.accountable&.role&.name
        }
        user
      end

      attribute :likes do |object|
        object.likes.count
      end

      attributes :replies do |object, params|
        replies = {
            count: object.comments.non_offensive.count,
            replies: RepliesSerializer.new(object.comments.non_offensive, params: {current_user: params[:current_user]}).serializable_hash
        }
      end

      attribute :image do |object|
        image = get_image_url(object.accountable) ? get_image_url(object.accountable) : ""
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') if image == ""
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end

      attribute :is_liked do |object, params|
        params[:current_user].likes.where(objectable: object).present?
      end

      attribute :is_reported do |object, params|
        params[:current_user].reports.where(reportable: object).present?
      end

      attribute :posted_at do |object|
        @@time_helper.format_time_in_ago(object.created_at) if object.created_at.present?
      end

    end
  end
  
