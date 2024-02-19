module BxBlockAdmin
  class SkinClinicsController < ApplicationController
    before_action :current_user

    def index
      skin_clinics = BxBlockSkinClinic::SkinClinic.all
      render json: BxBlockSkinClinic::SkinClinicSerializer.new(skin_clinics).serializable_hash,
        status: :ok
    end

    def create
      skin_clinic = BxBlockSkinClinic::SkinClinic.new(skin_clinic_params)
      if skin_clinic.save
        render json: BxBlockSkinClinic::SkinClinicSerializer.new(skin_clinic).serializable_hash,
          status: :created
      else
        render json: { errors: skin_clinic.errors }, status: :unprocessable_entity
      end
    end

    def show
      skin_clinic = BxBlockSkinClinic::SkinClinic.find(params[:id])
      render json: BxBlockSkinClinic::SkinClinicSerializer.new(skin_clinic).serializable_hash,
        status: :ok
    end

    def update
      skin_clinic = BxBlockSkinClinic::SkinClinic.find(params[:id])
      if skin_clinic.update(skin_clinic_params)
        render json: BxBlockSkinClinic::SkinClinicSerializer.new(skin_clinic).serializable_hash,
          status: :ok
      else
        render json: { errors: skin_clinic.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      skin_clinic = BxBlockSkinClinic::SkinClinic.find(params[:id])
      skin_clinic.destroy!
      render json: { message: 'successfully deleted' }, status: :ok
    end

    private

    def skin_clinic_params
      params["data"].require(:attributes).permit(:name, :location, :longitude, :latitude, :clinic_link, skin_clinic_availabilities_attributes: [:id, :day, :from, :to, :skin_clinic_id])
    end

  end
end