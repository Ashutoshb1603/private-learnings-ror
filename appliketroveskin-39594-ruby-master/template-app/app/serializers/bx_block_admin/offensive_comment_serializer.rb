module BxBlockAdmin
  class OffensiveCommentSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
      @@time_helper = Helpers::TimeHelper.new
      attributes :id, :description, :user, :created_at, :posted_at

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

      attribute :post_title do |object|
        object&.objectable_type == "BxBlockCommunityforum::Comment" ? object&.objectable&.objectable&.title : object&.objectable&.title
      end

      attribute :offensive_words do |object|
        words = []
        words = BxBlockCommunityforum::BadWordset.first.words.split(/[\n\r,]+/) if BxBlockCommunityforum::BadWordset.first.present?
        str = object.description.downcase
        str_arr = str.split(/[\n\r, ]+/).map(&:downcase)
        {
          description: words & str_arr
        }
      end
  end
end
