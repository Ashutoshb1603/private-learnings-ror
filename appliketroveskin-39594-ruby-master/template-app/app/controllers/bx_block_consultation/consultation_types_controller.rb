module BxBlockConsultation
  class ConsultationTypesController < ApplicationController
    def index
      consultation_types = ConsultationType.all
      render json: ConsultationTypeSerializer.new(consultation_types).serializable_hash,
               status: :ok
    end
  end
end