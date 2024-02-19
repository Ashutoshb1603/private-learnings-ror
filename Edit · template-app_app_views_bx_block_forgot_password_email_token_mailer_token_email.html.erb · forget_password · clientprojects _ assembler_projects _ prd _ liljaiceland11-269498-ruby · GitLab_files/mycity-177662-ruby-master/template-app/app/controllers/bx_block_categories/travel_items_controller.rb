module BxBlockCategories
	class TravelItemsController < BxBlockCategories::ApplicationController
	
    def create
    	get_params = create_params
    	travel_item = BxBlockCategories::TravelItem.find_or_initialize_by(get_params)
      travel_item.account_id = @current_user.id
    	if travel_item.save 
    		render json: {message: "Travel Item created successfully..",
                      travel_item: BxBlockCategories::TravelItemSerializer.new(travel_item)
                    }, status: :created
    	else
    		render json: {errors: format_activerecord_errors(travel_item.errors)}
    	end
    end

    def index
      if request.headers[:token].present?
        validate_json_web_token
        current_user
      end

    	get_lists = BxBlockCategories::TravelItem.all
      if params[:language] == 'english'
        get_lists = get_lists.where('name IS NOT NULL')
      elsif params[:language] == 'arabic'
        get_lists = get_lists.where('name_ar IS NOT NULL')
      end
      get_lists = get_lists.page(@page || 1).per(50)

    	if get_lists.present?
    		render json: {travel_items: BxBlockCategories::TravelItemSerializer.new(get_lists, serialization_options).serializable_hash}
    	else
    		render json: {errors: "Travel Items are Not Present"}
    	end
    end

    def destroy
    	get_travel_item = BxBlockCategories::TravelItem.find_by(id: params[:id])
    	if get_travel_item.present?
    		get_travel_item.destroy
    		render json: {message: "#{get_travel_item.name} Travel item deleted successfully.."}
    	else
    		render json: {error: "Travel Item not Present"},status: :unprocessable_entity
    	end
    end

    private 

    def create_params
    	params.require(:data).permit(:name, :name_ar)
    end

		def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

    def serialization_options
      options = {}
      options[:params] = { current_user: @current_user, language: params[:language] }
      options
    end

	end
end
