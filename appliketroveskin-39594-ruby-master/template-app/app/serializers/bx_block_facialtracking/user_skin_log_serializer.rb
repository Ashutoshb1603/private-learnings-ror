module BxBlockFacialtracking
  class UserSkinLogSerializer < BuilderBase::BaseSerializer
    attributes :id, :other, :created_at, :updated_at

    attribute :skin_quiz do |object|
      skin_quiz = object.skin_quiz
      {
        id: skin_quiz.id,
        question: skin_quiz.question,
        short_text: skin_quiz.short_text,
        info_text: skin_quiz.info_text,
        question_type: skin_quiz.question_type,
        allows_multiple: skin_quiz.allows_multiple,
        choices: object.choices&.map{|choice| {
          id: choice.id,
          choice: choice.choice,
          active: choice.active,
          image: get_image_url(choice)
        }}
      }
    end
  end
end