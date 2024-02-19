module BxBlockSkinClinic
  class SkinClinic < ApplicationRecord
    self.table_name = :skin_clinics

    geocoded_by :location do |obj, results|
      if result = results.first
        obj.country = result.country
        obj.latitude = result.latitude
        obj.longitude = result.longitude
      end
    end
    reverse_geocoded_by :latitude, :longitude, address: :location
    validates :clinic_link, format: {with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'Please enter valid url'}, :allow_blank => true
    ## Associations
    has_many :skin_clinic_availabilities, dependent: :destroy
    has_many :page_clicks, as: :objectable, class_name: 'BxBlockSkinClinic::PageClick', dependent: :destroy
    accepts_nested_attributes_for :skin_clinic_availabilities, reject_if: :all_blank, allow_destroy: true

    ## Validations
    validates :name, :location, presence: true
    after_validation :geocode
    after_validation :reverse_geocode
  end
end