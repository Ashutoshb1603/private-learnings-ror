module BxBlockFacialtracking
  class UserImage < ApplicationRecord
    self.table_name = :user_images

    ## Associations
    belongs_to :account, polymorphic: true

    has_one_attached :image

    ## Validations
    validates :image, :position, presence: true
    validate  :validate_image_content_type

    scope :user_images_for_today, -> {where("created_at::date = ?", Date.today)}
    enum position: {left: "left", front: "front", right: "right"}

    def validate_image_content_type
      if image.present? && !["image/jpeg", "image/jpg", "image/png"].include?(image.content_type)
        errors.add(:base, "Image must be in jpg or png format")
      end
    end
  end
end