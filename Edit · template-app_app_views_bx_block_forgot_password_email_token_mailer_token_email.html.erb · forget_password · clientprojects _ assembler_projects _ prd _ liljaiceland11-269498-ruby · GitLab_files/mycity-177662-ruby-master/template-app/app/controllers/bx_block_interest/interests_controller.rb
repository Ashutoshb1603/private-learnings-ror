module BxBlockInterest
	class InterestsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include ActiveStorage::SetCurrent
    before_action :validate_json_web_token, except: [:index, :get_interests]
    before_action :current_user, except: [:index, :get_interests]
    before_action :page_from_params
		before_action :resize_image, only: [:create,:update]

    def create
    	interests = BxBlockInterests::Interest.new(create_params)
    	interests.created_by = @current_user.id
    	
    	if interests.save
    		render json: {interests: BxBlockInterests::InterestSerializer.new(interests)}
    	else
    		render json: {errors: "interests not created.."}
    	end
    end

		def get_interests
			interests = BxBlockInterests::Interest.all
			if params[:language] == 'english'
				interests = interests.where('name IS NOT NULL')
			elsif params[:language] == 'arabic'
				interests = interests.where('name_ar IS NOT NULL')
			end

			if params[:search].present?
				interests = interests.where('name ILIKE ?', "%#{params[:search].downcase}%")
			end

			if request.headers[:token].present?
	  		validate_json_web_token
	  		current_user
	  	end
	  	interests = interests.page(@page || 1).per(50)
			render json:{ interests: BxBlockInterests::InterestSerializer.new(interests, serialization_options).serializable_hash}
		end


		private

		def create_params
			params.require(:interests).permit(:name,:icon)
		end

		def current_user
      @current_user ||= AccountBlock::Account.find_by_id(@token&.id)
      return render json: {status: 422, error: 'Invalid token' }, status: 422 if @current_user.blank? || !@current_user.activated
    end

    def serialization_options
      options = {}
      options[:params] = { current_user: @current_user, language: params[:language] }
      options
    end

		def resize_image
			img = create_params[:icon]
			content_type = img.content_type 
			path = img.tempfile.path
			image = MiniMagick::Image.open(path.to_s)
			image.resize "280x150"    
			if ["image/jpg","image/png","image/jpeg"].include?(content_type)
				img.tempfile = image.tempfile
			end
    end
	end
end
