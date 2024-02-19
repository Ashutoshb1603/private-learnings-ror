module BxBlockConsultation
  class UserConsultationSerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :email, :phone_number, :age, :address, :booked_datetime, :therapist_id, :created_at, :updated_at
  
    attribute :image do |object, params|
      get_image_url(object)
    end
  end
end