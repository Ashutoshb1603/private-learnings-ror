module BxBlockConsultation
  class UserConsultationDetailsSerializer < BuilderBase::BaseSerializer
    attributes :id, :name, :email, :phone_number, :age, :address, :booked_datetime, :therapist_id, :created_at, :updated_at
  
    attribute :image do |object, params|
      get_image_url(object)
    end

    attribute :account_choice_skin_consultations do |object, params|
      consultations = object.account.account_choice_skin_consultations.where("account_choice_skin_logs.created_at::date = ?",Date.today).uniq
      BxBlockFacialtracking::AccountChoiceSkinLogSerializer.new(consultations)
    end
  end
end