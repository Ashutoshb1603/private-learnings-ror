module BxBlockCategories
	class ActivitiesController < BxBlockCategories::ApplicationController
    
    def create
    	activity = BxBlockCategories::Activity.find_or_initialize_by(create_params)
      activity.status = 'approved'
      activity.account_id = @current_user.id
    	if activity.save 
    		render json: {message: "Activity created successfully..",
                      activity: BxBlockCategories::ActivitySerializer.new(activity)
                    }, status: :created
    	else
    		render json: {errors: format_activerecord_errors(activity.errors)}
    	end
    end

    def index
      if request.headers[:token].present?
        validate_json_web_token
        current_user
      end

    	lists = BxBlockCategories::Activity.approved
      if params[:language] == 'english'
        lists = lists.where('name IS NOT NULL')
      elsif params[:language] == 'arabic'
        lists = lists.where('name_ar IS NOT NULL')
      end

      lists = lists.page(@page || 1).per(50)
    	if lists.present?
    		render json: {activities: BxBlockCategories::ActivitySerializer.new(lists, serialization_options).serializable_hash}
    	else
    		render json: {message: "Activities are Not Present"}
    	end
    end

    def destroy
    	get_activity = BxBlockCategories::Activity.find_by(id: params[:id])
    	if get_activity.present?
    		get_activity.destroy
    		render json: {message: "#{get_activity.name} activity deleted successfully.."}
    	else
    		render json: {error: "Activity not Present"},status: :unprocessable_entity
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
