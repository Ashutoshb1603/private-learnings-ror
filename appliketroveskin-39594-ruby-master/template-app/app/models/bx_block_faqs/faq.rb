module BxBlockFaqs
  class Faq < ApplicationRecord
    self.table_name = :faqs

    ## Validations
    validates :question, :answer, presence: true
  end
end