module BxBlockEquipments
  class EquipmentsController < ApplicationController
    before_action :validate_json_web_token, except: [:index]

    def create
    	get_params = create_params
    	equipment = BxBlockEquipments::Equipment.find_or_create_by(get_params)
    	if equipment.save 
    		render json: { message: "equipment created successfully..",
          equipment: BxBlockEquipments::EquipmentSerializer.new(equipment)
                    }
    	else
    		render json: {errors: format_activerecord_errors(equipment.errors)}
    	end
    end

    def index
    	get_lists = BxBlockEquipments::Equipment.approved
    	if get_lists.present?
    		render json: {equipments: BxBlockEquipments::EquipmentSerializer.new(get_lists)}
    	else
    		render json: {errors: "Equipments are Not Present"}
    	end
    end

    def update
      equipment = BxBlockEquipments::Equipment.find(params[:id])
      if equipment.present?
        if equipment.update(create_params)
          render json: {message: "#{equipment.name} - equipment updated successfully.."}
        else
          render json: {errors: format_activerecord_errors(equipment.errors)}
    	  end
      else
    		render json: {message: "Equipment not Present"},status: :unprocessable_entity
    	end
    end

    def destroy
    	get_equipment = BxBlockEquipments::Equipment.find(id: params[:id])
    	if get_equipment.present?
    		get_equipment.destroy
    		render json: { message: "#{get_equipment.name} equipment deleted successfully.." }
    	else
    		render json: {message: "Equipment not Present"}, status: :unprocessable_entity
    	end
    end

    private 

    def create_params
    	params.require(:data).permit(:name)
    end

		def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end
  end
end
