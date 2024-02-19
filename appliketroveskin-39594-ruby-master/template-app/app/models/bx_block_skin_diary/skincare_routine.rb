module BxBlockSkinDiary
  class SkincareRoutine < ApplicationRecord
    self.table_name = :skincare_routines
    belongs_to :account, polymorphic: true
    belongs_to :therapist, polymorphic: true
    has_many :skincare_steps, class_name: 'BxBlockSkinDiary::SkincareStep', dependent: :destroy
    enum routine_type: {'am_routine': 1, 'pm_routine': 2, 'suppliments': 3, 'masks': 4, 'booster_treatment': 5, 'notes': 6}

    accepts_nested_attributes_for :skincare_steps, allow_destroy: true

    def self.routine_types
      {'AM Routine': 1, 'PM routine': 2, 'Suppliments': 3, 'Masks': 4, 'Booster Treatment': 5, 'Notes': 6}
    end

  end
end
