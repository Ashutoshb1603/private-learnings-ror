module BxBlockAdmin
  class OffensiveQuestionSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
      @@time_helper = Helpers::TimeHelper.new
      attributes :id, :title, :description, :groups, :anonymous, :user, :created_at, :posted_at

      attribute :user do |object|
        user = {
            name: object.accountable.name,
            id: object.accountable.id,
            profile_image: get_image_url(object.accountable),
            blocked: object&.accountable&.blocked
        }
        user
      end

      attribute :posted_at do |object|
        @@time_helper.format_time_in_ago(object.created_at)
      end

      attribute :offensive_words do |object|
        words = []
        words = BxBlockCommunityforum::BadWordset.first.words.split(/[\n\r,]+/) if BxBlockCommunityforum::BadWordset.first.present?
        str = object.description.downcase
        title = object.title.downcase
        str_arr = str.split(/[\n\r, ]+/).map(&:downcase)
        title_arr = title.split(/[\n\r, ]+/).map(&:downcase)
        description = words & str_arr
        title = words & title_arr
        {
          title: title,
          description: description
        }
      end
  end
end
