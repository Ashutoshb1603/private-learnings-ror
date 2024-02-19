module BxBlockCatalogue
  class Advertisement < BxBlockCatalogue::ApplicationRecord
    self.table_name = :advertisements
    has_one_attached :image

    validate :validate_image_content_type
    validates :image, :dimension, presence: true
    validates :url, format: {with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'Please enter valid url'}, :allow_blank => true
    scope :active, -> {where(active: true)}
    has_many :page_clicks, as: :objectable, class_name: 'BxBlockSkinClinic::PageClick', dependent: :destroy
    
    enum dimension: {"347 * 60": "347 * 60", "347 * 100": "347 * 100", "347 * 250": "347 * 250"}

    def validate_image_content_type
      if image.present? && !["image/jpeg", "image/jpg", "image/png"].include?(image.content_type)
        errors.add(:base, "Image must be in jpg or png format")
      end
    end
  end
end