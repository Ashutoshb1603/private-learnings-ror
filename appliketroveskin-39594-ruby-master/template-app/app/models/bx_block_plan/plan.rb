module BxBlockPlan
  class Plan < ApplicationRecord
    self.table_name = :plans
    has_many :payments, class_name: 'BxBlockPayments::Payment'

    enum period: {'month': 1, 'year': 2}
  end
end
