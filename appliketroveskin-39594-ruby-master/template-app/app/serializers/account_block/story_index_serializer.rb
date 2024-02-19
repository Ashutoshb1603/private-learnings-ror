module AccountBlock
    class StoryIndexSerializer < BuilderBase::BaseSerializer
      attributes *[
        :id,
        :first_name,
        :profile_pic,
        :is_viewed,
        :current_therapist_stories,
        :stories
      ]

      attribute :profile_pic do |object|
        image = get_image_url(object) ? get_image_url(object) : ""
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') if image == ""
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end

      attribute :stories do |object, params|
        current_user = params[:current_user]
        stories = object.stories.where('stories.created_at >= ?', 24.hours.ago)
        StoriesSerializer.new(stories, params: {current_user: current_user}).serializable_hash
      end

      attribute :is_viewed do |object, params|
        current_user = params[:current_user]
        account_type = current_user.type == "AdminUser" ? "AdminUser" : "AccountBlock::Account"
        object.stories.count == object.stories.joins(:story_views).
                                  where('story_views.accountable_id = ? and story_views.accountable_type = ?', current_user.id, account_type).count
      end

      attribute :current_therapist_stories do |object, params|
        current_user = params[:current_user]
        current_user == object
      end

    end
  end
  