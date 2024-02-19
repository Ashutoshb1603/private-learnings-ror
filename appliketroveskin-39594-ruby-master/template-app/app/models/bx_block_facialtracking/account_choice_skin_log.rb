module BxBlockFacialtracking
  class AccountChoiceSkinLog < ApplicationRecord
    self.table_name = :account_choice_skin_logs

    ## Associations
    belongs_to :account, polymorphic: true
    belongs_to :skin_quiz

    ## Validations
    validate :validate_choices, if: -> {choice_ids.present?}
    validates :choice_ids, presence: true, if: -> {skin_quiz.choices.present? and !self.other.present?}
    validate  :validate_choice_length, if: -> {skin_quiz.choices.present?}

    has_one_attached :image, dependent: :destroy

    def validate_choices
      choices = Choice.where(id: choice_ids)
      self.choice_ids = choices.ids
      unless choices.present?
        errors.add(:choice, "Choices not present for gived ids")
      end
    end

    def validate_choice_length
      if !skin_quiz.allows_multiple && choice_ids.length > 1
        errors.add(:choice, "You can't select multiple choices for this question")
      end
    end

    def choices
      Choice.where(id: choice_ids) if choice_ids.present?
    end
  end
end