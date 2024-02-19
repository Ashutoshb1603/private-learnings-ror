module BxBlockSkinClinic
    class SkinTreatmentLocationsController < ApplicationController
        def index
            @skin_treatment_location = BxBlockSkinClinic::SkinTreatmentLocation.all
            render json: SkinTreatmentLocationSerializer.new(@skin_treatment_location).serializable_hash
        end
    end
end