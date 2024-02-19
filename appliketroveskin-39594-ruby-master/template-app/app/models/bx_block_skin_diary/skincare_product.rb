module BxBlockSkinDiary
  class SkincareProduct < ApplicationRecord
    belongs_to :skincare_step, :class_name => "BxBlockSkinDiary::SkincareStep"
  end
end
