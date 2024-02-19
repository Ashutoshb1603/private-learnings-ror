module AccountBlock
    class StoriesSerializer < BuilderBase::BaseSerializer
      attributes *[
        :id,
        :video,
        :profile_pic,
        :name,
        :first_name,
        :target,
        :is_viewed,
        :views
      ]
  
      attribute :video do |object|
        get_video_url(object)
      end

      attribute :profile_pic do |object|
        image = get_image_url(object.objectable) ? get_image_url(object.objectable) : ""
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') if image == ""
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end

      attribute :name do |object|
        object.objectable.name
      end

      attribute :first_name do |object|
        object.objectable.first_name.to_s
      end

      attribute :is_viewed do |object, params|
        params[:current_user].story_views.where(story_id: object.id).present?
      end

      attribute :views do |object, params|
        if object.objectable == params[:current_user]
          users = []
          object.story_views.each do |story_view|
            users << {
              id: story_view.accountable_id,
              first_name: story_view.accountable.try(:first_name),
              name: story_view.accountable&.name
            }
          end
          {
            count: object.story_views.count,
            users: users
          }
        else
          {
            count: nil,
            users: []
          }
        end
      end
    end
  end
  