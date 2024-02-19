module BxBlockConsultation
  class UserConsultationsController < ApplicationController
    before_action :current_user

    def create
      user_consultation = @current_user.user_consultations.find_by("created_at::date = ?", Date.today) || @current_user.user_consultations.new(user_consultation_params)
      save_result = user_consultation.present? ? user_consultation.update(user_consultation_params) : user_consultation.save

      if save_result
        render json: UserConsultationSerializer.new(user_consultation).serializable_hash,
               status: :created
      else
        render json: {errors: {message: user_consultation.errors.full_messages}},
               status: :unprocessable_entity
      end
    end

    def user_consultation
      user_consultation = @current_user.user_consultations.find_by("created_at::date = ?", Date.today)
      render json: UserConsultationDetailsSerializer.new(user_consultation).serializable_hash,
               status: :ok
    end

    private

    def user_consultation_params
      params.require(:user_consultation).permit(:name, :phone_number, :email, :age, :address, :booked_datetime, :therapist_id, :image)
    end
  end
end