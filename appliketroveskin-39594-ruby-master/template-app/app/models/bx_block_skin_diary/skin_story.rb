module BxBlockSkinDiary
  class SkinStory < ApplicationRecord
    self.table_name = :skin_stories
    belongs_to :concern

    has_one_attached :before_image
    has_one_attached :after_image
  end
end
