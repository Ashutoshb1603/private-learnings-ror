module BxBlockFacialtracking
  class SkinQuiz < ApplicationRecord
    self.table_name = :skin_quizzes
    include Wisper::Publisher
    has_many :choices, dependent: :destroy, class_name: 'BxBlockFacialtracking::Choice'
    has_many :account_choice_skin_quizzes, dependent: :nullify
    has_many :account_choice_skin_logs, dependent: :nullify
    accepts_nested_attributes_for :choices,  allow_destroy: true

    ## Scopes
    default_scope{order(:seq_no)}
    scope :active, -> {where(active: true)}
    scope :active_skin_logs, -> {where(active:true, question_type: 'skin_log')}
    scope :active_signup_quizzes, -> {where(active:true, question_type: 'sign_up')}
    scope :active_skin_goals, -> {where(active:true, question_type: 'skin_goal')}

    ## Validations
    validates :question, :seq_no, :question_type, presence: true
    validates :seq_no, uniqueness: true
    enum question_type: {sign_up: "sign_up", skin_log: "skin_log", skin_goal: "skin_goal", consultation: 'consultation'}

    ## Callbacks
    after_update :update_choices, if: -> {saved_change_to_active?}
    validate  :validate_skin_quiz

    def update_choices
      choices&.update_all(active: active)
    end

    def validate_skin_quiz
      existing_question = SkinQuiz.where(question_type: question_type, question: question)&.first
      if existing_question.present? && existing_question.id != self.id
        errors.add(:question, "#{question} already taken for #{question_type} category")
      end
    end
  end
end
