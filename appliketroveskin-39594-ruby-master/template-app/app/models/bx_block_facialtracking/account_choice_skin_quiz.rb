module BxBlockFacialtracking
  class AccountChoiceSkinQuiz < ApplicationRecord
    self.table_name = :account_choice_skin_quizzes

    ## Associations
    belongs_to :skin_quiz, class_name: 'SkinQuiz'
    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :choice, class_name: 'Choice'
  end
end
