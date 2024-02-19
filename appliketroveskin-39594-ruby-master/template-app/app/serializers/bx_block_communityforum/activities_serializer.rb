module BxBlockCommunityforum
    class ActivitiesSerializer < BuilderBase::BaseSerializer
      attributes :id, :description, :accountable_id, :action, :objectable_type, :objectable_id, :created_at, :posted_at, :concern_mail_id, :profile_image
      @@time_helper = Helpers::TimeHelper.new

      attribute :description do |object, params|
        message = ""
        type = object.objectable_type.split("::").second
        objectable = type == "Question" ? "post" : type == "Comment" ? "comment" : "reply"
        if params[:activity_type] == "other_users"
            message = "#{object.accountable.name} liked your #{objectable}" if object.action == "liked"
            message = "#{object.accountable.name} commented on your post" if object.action == "commented"
            message = "#{object.accountable.name} mentioned you in a comment" if object.action == "mentioned"
            message = "#{object.accountable.name} replied to your comment" if object.action == "replied"
        else
            message = "You liked #{object.user_activity.name}'s #{objectable}" if object.action == "liked"
            message = "You commented on #{object.user_activity.name}'s post" if object.action == "commented"
            message = "You mentioned #{object.user_activity.name} in a comment" if object.action == "mentioned"
            message = "You replied to #{object.user_activity.name}'s comment" if object.action == "replied"
        end
        message
      end

      attribute :profile_image do |object|
        image = get_image_url(object.accountable) ? get_image_url(object.accountable) : ""
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') if image == ""
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end

      attribute :post_id do |object|
        type = object.objectable_type.split("::").second
        post_id = type == "Question" ? object.objectable_id : object.objectable.objectable_type == "BxBlockCommunityforum::Question" ? object.objectable.objectable.id : object.objectable.objectable.objectable.id
      end

      attribute :posted_at do |object|
        @@time_helper.format_time_in_ago(object.created_at)
      end

    end
  end
  