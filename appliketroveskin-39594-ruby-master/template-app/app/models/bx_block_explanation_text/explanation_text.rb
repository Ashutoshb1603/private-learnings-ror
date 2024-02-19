module BxBlockExplanationText
  class ExplanationText < ApplicationRecord
    self.table_name = :explanation_texts

    ## Validations
    validates :section_name, :value, presence: true
  end
end