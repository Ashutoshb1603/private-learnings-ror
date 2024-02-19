module BxBlockSkinClinic
  class SkinClinicAvailability < ApplicationRecord
    belongs_to :skin_clinic

    self.table_name = :skin_clinic_availabilities

    ## Validations
    validates :day, :from, :to, presence: true
    before_validation :validate_availability

    def validate_availability
      existing_availability = skin_clinic.skin_clinic_availabilities.where(day: day).first
      if existing_availability.present? && existing_availability.id != self.id
        errors.add(:day, "Availability for #{day} already exists.")
      end
    end
  end
end