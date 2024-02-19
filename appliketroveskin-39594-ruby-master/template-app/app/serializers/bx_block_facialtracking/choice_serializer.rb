module BxBlockFacialtracking
  class ChoiceSerializer < BuilderBase::BaseSerializer
    attributes :id, :choice, :skin_quiz_id, :active, :created_at, :updated_at, :image

    attribute :image do |object|
      if object.skin_quiz.skin_log? || object.skin_quiz.skin_goal?
        get_image_url(object)
      end
    end
  end
end