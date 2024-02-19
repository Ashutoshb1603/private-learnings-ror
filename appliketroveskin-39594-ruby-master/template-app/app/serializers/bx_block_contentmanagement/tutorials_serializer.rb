module BxBlockContentmanagement
    class TutorialsSerializer < BuilderBase::BaseSerializer
      @@time_helper = Helpers::TimeHelper.new
      attributes :id, :title, :description, :url, :group, :created_at, :posted_at, :likes, :views, :is_liked, :next

      attribute :group do |object|
        object.group.title
      end

      attribute :likes do |object|
        object.tutorial_likes.count
      end

      attribute :views do |object|
        object.tutorial_views.count
      end

      attribute :is_liked do |object, params|
        object.tutorial_likes.where(account_id: params[:current_user].id).present?
      end

      attribute :posted_at do |object|
        @@time_helper.format_time_in_ago(object.created_at)
      end

      attribute :next do |object|
        object.next
      end

    end
  end
  