module BxBlockConsultation
  class ConsultationType < ApplicationRecord
    self.table_name = :consultation_types

    ## Validation
    validates :name, :price, :description, presence: true
  end
end 