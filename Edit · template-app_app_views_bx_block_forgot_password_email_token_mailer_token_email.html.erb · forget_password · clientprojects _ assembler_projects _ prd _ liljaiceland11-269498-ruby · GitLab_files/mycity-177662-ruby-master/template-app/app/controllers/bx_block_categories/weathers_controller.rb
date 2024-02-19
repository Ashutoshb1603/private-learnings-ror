module BxBlockCategories
	class WeathersController < BxBlockCategories::ApplicationController
		
    def index
      if request.headers[:token].present?
        validate_json_web_token
        current_user
      end

    	get_lists = BxBlockCategories::Weather.all
    	if params[:language] == 'english'
        get_lists = get_lists.where('name IS NOT NULL')
      elsif params[:language] == 'arabic'
        get_lists = get_lists.where('name_ar IS NOT NULL')
      end
      get_lists = get_lists.page(@page || 1).per(50)
      if get_lists.present?
    		render json: {activities: BxBlockCategories::WeatherSerializer.new(get_lists, serialization_options).serializable_hash}
    	else
    		render json: {errors: "Weathers are Not Present"}
    	end
    end

    def create
    	weather = BxBlockCategories::Weather.find_or_initialize_by(create_params)
      weather.account_id = @current_user.id
    	if weather.save 
    		render json: {message: "Weather created successfully..",
    			weather: BxBlockCategories::WeatherSerializer.new(weather)}, status: :created
    	else
    		render json: {errors: format_activerecord_errors(weather.errors)}
    	end
    end

    def destroy
    	get_weather = BxBlockCategories::Weather.find_by(id: params[:id])
    	if get_weather.present?
    		get_weather.destroy
    		render json: {message: "#{get_weather.name} weather deleted successfully.."}
    	else
    		render json: {error: "Weather not Present"},status: :unprocessable_entity
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
