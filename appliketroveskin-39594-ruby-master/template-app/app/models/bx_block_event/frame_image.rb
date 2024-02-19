module BxBlockEvent
  class FrameImage < ApplicationRecord
    ## Associations
    belongs_to :life_event

    self.table_name = :frame_images

    has_one_attached :image
    ## Enumerations
    enum user_type: {bronze: 'bronze', glow_getter: 'glow_getter'}

    ## Validations
    validates :user_type, :image, presence: true
    validate  :validate_image_content_type

    def validate_image_content_type
      if image.present? && !["image/jpeg", "image/jpg", "image/png"].include?(image.content_type)
        errors.add(:image, "Image must be in jpg or png format")
      end
    end
  end
end