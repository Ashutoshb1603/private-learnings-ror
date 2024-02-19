module BxBlockAdmin
  class TermsAndCondition < BxBlockAdmin::ApplicationRecord
    self.table_name = :terms_and_conditions
    before_validation :restrict_to_create_multiple, on: :create

    private 

    def restrict_to_create_multiple
      count = BxBlockAdmin::TermsAndCondition.all
      if count.present?
        errors.add(:description, "Can't create multiple Terms And Conditions")
        errors.add(:description_ar, "Can't create multiple Terms And Conditions")
      end
    end
  end
end
