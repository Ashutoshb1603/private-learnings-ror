module BxBlockFacialtracking
  class Choice < ApplicationRecord
    self.table_name = :choices
    include Wisper::Publisher

    belongs_to :skin_quiz, class_name: 'BxBlockFacialtracking::SkinQuiz'
    has_many   :account_choice_skin_quizzes, dependent: :nullify
    has_many   :choice_tags, class_name: 'BxBlockFacialtracking::ChoiceTag', dependent: :destroy
    has_many   :tags, through: :choice_tags, class_name: 'BxBlockCatalogue::Tag'

    has_one_attached :image

    ## Scopes
    scope :active, -> {where(active: true)}

    ## Validations
    validate  :validate_image_content_type

    def validate_image_content_type
      if image.present? && !["image/jpeg", "image/jpg", "image/png"].include?(image.content_type)
        errors.add(:base, "Image must be in jpg or png format")
      end
    end
  end
end
