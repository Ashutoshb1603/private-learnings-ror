module BxBlockSkinDiary
  class SkincareStepNote < ApplicationRecord
    self.table_name = :skincare_step_notes
    belongs_to :skincare_step, :class_name => "BxBlockSkinDiary::SkincareStep"

  end
end
