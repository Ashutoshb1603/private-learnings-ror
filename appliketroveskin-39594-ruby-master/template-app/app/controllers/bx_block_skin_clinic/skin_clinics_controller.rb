module BxBlockSkinClinic
  class SkinClinicsController < ApplicationController
    before_action :current_user

    def index
      if params[:location].present?
        skin_clinics = SkinClinic.where(country: params[:location]).includes(:skin_clinic_availabilities)
        render json: SkinClinicSerializer.new(skin_clinics).serializable_hash,
               status: :ok
      else
        render json: {errors: {message: 'Please pass location to get skin clinics around you.'}},
               status: :unprocessable_entity
      end
    end

    def show
      skin_clinic = SkinClinic.find(params[:id])
      BxBlockSkinClinic::PageClick.increment_click_count(@current_user, skin_clinic)
      render json: SkinClinicSerializer.new(skin_clinic).serializable_hash,
             status: :ok
    end
  end
end