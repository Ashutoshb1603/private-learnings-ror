module BxBlockFacialtracking
    class ConsultationFormSerializer < BuilderBase::BaseSerializer
      attributes :id, :skin_quiz, :other, :created_at, :updated_at
  
      attribute :skin_quiz do |object, params|
        skin_quiz = object
        {
          id: skin_quiz.id,
          question: skin_quiz.question,
          question_type: skin_quiz.question_type,
          allows_multiple: skin_quiz.allows_multiple,
          info_text: skin_quiz.info_text,
          choices: object.choices&.map{|choice| {
            id: choice.id,
            choice: choice.choice,
            active: choice.active,
            image: get_image_url(choice),
            checked: (object.account_choice_skin_logs.find_by(account_id: params[:current_user].id)&.choices&.pluck(:id)&.include? choice.id) || false
          }}
        }
      end

      attribute :other do |object, params|
        object.account_choice_skin_logs.find_by(account_id: params[:current_user].id)&.other || ""
      end

      attribute :image do |object, params|
        get_image_url(object.account_choice_skin_logs.find_by(account_id: params[:current_user].id)) || ""
      end
    end
  end