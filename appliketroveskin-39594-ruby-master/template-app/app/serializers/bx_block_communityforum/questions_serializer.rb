module BxBlockCommunityforum
    class QuestionsSerializer < BuilderBase::BaseSerializer
      @@time_helper = Helpers::TimeHelper.new
      attributes :id, :title, :description, :groups, :anonymous, :user, :created_at, :posted_at, :images, :likes, :comments, :views, :is_liked, :is_saved, :user_type, :offensive, :recommended
      
      attribute :user do |object|
        image_type = (object.accountable_type == "AdminUser") ? 'admin' : 'profile_pic'
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type(image_type)
        image = get_image_url(dynamic_image) ? get_image_url(dynamic_image) : ""
        user = {
            name: object.accountable&.name,
            id: object.accountable&.id,
            profile_image: get_image_url(object.accountable) ? get_image_url(object.accountable) : image,
            user_type: object&.accountable&.role&.name
        }
        user = {
            name: "Anonymous",
            id: nil,
            profile_image: image,
            user_type: 'user'
        } if object.anonymous
        user
      end

      attribute :groups do |object|
        object.groups.select(:id, :title)
      end

      attribute :likes do |object|
        object.likes.count
      end

      attribute :views do |object|
        object.views.count
      end

      attributes :comments do |object, params|
        comments = {
            count: object.comments.non_offensive.count,
            comments: CommentsSerializer.new(object.comments.non_offensive.order('created_at DESC'), params: {current_user: params[:current_user]}).serializable_hash
        }
      end

      attribute :images do |object|
        images = object.images.map do |image|
          base_url + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) if object.images.attached?
        end
      end

      attribute :is_liked do |object, params|
        params[:current_user].likes.where(objectable: object).present?
      end

      attribute :is_saved do |object, params|
        params[:current_user].saved.where(question_id: object.id).present?
      end

      attribute :is_reported do |object, params|
        params[:current_user].reports.where(reportable: object).present?
      end

      attribute :posted_at do |object|
        @@time_helper.format_time_in_ago(object.created_at)
      end

    end
  end
  
