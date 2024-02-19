module BxBlockCommunityforum
    class ProfileSerializer < BuilderBase::BaseSerializer
      @@questions = BxBlockCommunityforum::QuestionsController.new
      attributes :id, :posts_count, :replies, :likes, :posts, :profile_pic, :name, :location

      attribute :posts_count do |object|
        object.questions.count
      end

      attribute :replies do |object|
        object.comments.non_offensive.where(objectable_type: "BxBlockCommunityforum::Question").count
      end

      attribute :likes do |object|
        object.likes.where(objectable_type: "BxBlockCommunityforum::Question").count
      end

      attributes :posts do |object, params|
        @@questions.paginate_questions(object.questions, params[:page], object)
        # questions = QuestionsSerializer.new(object.questions, params: {current_user: object}).serializable_hash
      end

      attribute :profile_pic do |object|
        image = get_image_url(object) ? get_image_url(object) : ""
        dynamic_image = AccountBlock::DynamicImage.find_by_image_type('profile_pic') if image == ""
        image = get_image_url(dynamic_image) unless dynamic_image.nil?
        image
      end

      attribute :location do |object|
        object&.addresses&.first&.country || ""
      end

    end
  end
  