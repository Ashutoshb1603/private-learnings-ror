class BxBlockConsultation::UserConsultation < ApplicationRecord
  ## Associations
  belongs_to :account

  self.table_name = :user_consultations

  ## Attachments
  has_one_attached :image

  ## Validations
  validates :name, :phone_number, :address, :email, :age, :therapist_id, :booked_datetime, presence: true
end
