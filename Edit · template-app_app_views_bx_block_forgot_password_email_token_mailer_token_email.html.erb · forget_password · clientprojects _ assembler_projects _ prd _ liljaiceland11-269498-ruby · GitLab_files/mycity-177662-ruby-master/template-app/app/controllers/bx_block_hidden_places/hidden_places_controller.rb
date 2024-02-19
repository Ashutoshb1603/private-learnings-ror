 module BxBlockHiddenPlaces
	class HiddenPlacesController < BxBlockHiddenPlaces::ApplicationController
		before_action :validate_json_web_token, :check_account_activated, except: [:index, :show, :search_by_activity, :search_by_travel_item, :search_by_weather, :events_around_the_place]
		before_action :load_hidden_place, only: [:destroy, :update]
		before_action :page_from_params
		before_action :resize_image, only: [:create,:update]
		before_action :load_place, only: [:show]

		def index
			get_places = BxBlockHiddenPlaces::HiddenPlace.all.page(@page).per(@per_page)
    	if get_places
    		render json: {get_places: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(get_places)}
    	else
    		render json: {errors: "Hidden Places are Empty"}
    	end
		end

		def create
			hidden_place = BxBlockHiddenPlaces::HiddenPlace.new(create_params)
			hidden_place.activity_ids = create_params[:activity_ids].is_a?(String) ? create_params[:activity_ids].split(',') : create_params[:activity_ids]
			hidden_place.travel_item_ids = create_params[:travel_item_ids].is_a?(String) ? create_params[:travel_item_ids].split(',') : create_params[:travel_item_ids]
			hidden_place.weather_ids = create_params[:weather_ids].is_a?(String) ? create_params[:weather_ids].split(',') : create_params[:weather_ids]
			hidden_place.account_id = @current_user.id
			if hidden_place.save
				mail_nearby_users(hidden_place)
				render json: {message: "Hidden place created successfully", hidden_places: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(hidden_place).serializable_hash }, status: :created
			else
				render json: {status: 422, errors: format_activerecord_errors(hidden_place.errors)}, status: 422
			end
		end

		def update
			update_params = create_params
			update_params[:activity_ids] = create_params[:activity_ids].is_a?(String) ? create_params[:activity_ids].split(',') : create_params[:activity_ids] if create_params.has_key?(:activity_ids)
			update_params[:travel_item_ids] = create_params[:travel_item_ids].is_a?(String) ? create_params[:travel_item_ids].split(',') : create_params[:travel_item_ids] if create_params.has_key?(:travel_item_ids)
			update_params[:weather_ids] = create_params[:weather_ids].is_a?(String) ? create_params[:weather_ids].split(',') : create_params[:weather_ids] if create_params.has_key?(:weather_ids)

			if @hidden_place.update(update_params)
				render json: {message: "Hidden place updated successfully", hidden_places: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(@hidden_place).serializable_hash }, status: 200
			else
				render json: {status: 422, errors: 'Unable to update place details'}, status: 422
			end
		end

		def destroy
			# hidden_place = BxBlockHiddenPlaces::HiddenPlace.find_by(account_id: @current_user.id,id: params[:id])
    	if @hidden_place.present?
    		@hidden_place.destroy
    		render json: {message: "#{@hidden_place.place_name} hidden place deleted successfully.."}
    	else
    		render json: {error: "Hidden place not Present"},status: :unprocessable_entity
    	end
		end

		def my_places
			get_places = BxBlockHiddenPlaces::HiddenPlace.where(account_id: @current_user.id).order(id: :desc).page(@page).per(@per_page)
    	if get_places
    		render json: {get_places: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(get_places).serializable_hash }
    	else
    		render json: {error: "Empty place"}
    	end
		end

		def show
			render json: {message: "Hidden place details", hidden_places: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(@hidden_place).serializable_hash }, status: 200
		end

		def search
			if params[:search].present?
				lists = BxBlockAnalytics9::SearchDocument.search_by_words(params[:search])
			else
				lists = BxBlockAnalytics9::SearchDocument.all
			end

			if params[:latitude].present? && params[:longitude].present?
				lists = lists.near([params[:latitude], params[:longitude]], 50, units: :km)
			end
			
			data = BxBlockPosts::HomeSerializer.new(lists.page(@page).per(@per_page)).serializable_hash
			render json: {status: 200, data: data}, status: 200
		end

		def search_by_activity
			if params[:activity_id].present?
				hidden_places = BxBlockHiddenPlaces::HiddenPlace.joins(:activities).where(activities: {id: params[:activity_id]}).page(@page).per(@per_page)
				render json: {data: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(hidden_places).serializable_hash }, status: 200
			else
				render json: {status: 422, error: 'Id is missing'}, status: 422
			end
		end

		def search_by_travel_item
			if params[:travel_item_id].present?
				hidden_places = BxBlockHiddenPlaces::HiddenPlace.joins(:travel_items).where(travel_items: {id: params[:travel_item_id]}).page(@page).per(@per_page)
				render json: {data: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(hidden_places).serializable_hash }, status: 200
			else
				render json: {status: 422, error: 'Id is missing'}, status: 422
			end
		end

		def search_by_weather
			if params[:weather_id].present?
				hidden_places = BxBlockHiddenPlaces::HiddenPlace.joins(:weathers).where(weathers: {id: params[:weather_id]}).page(@page).per(@per_page)
				render json: {data: BxBlockHiddenPlaces::HiddenPlaceSerializer.new(hidden_places).serializable_hash }, status: 200
			else
				render json: {status: 422, error: 'Id is missing'}, status: 422
			end
		end

		def mail_nearby_users(hidden_place)
			accounts = AccountBlock::Account.active.near(hidden_place.to_coordinates, 100, units: :km)
			# remarks = "New hidden place added"
			# content = "New hidden place #{hidden_place.place_name} create around you."
			# BxBlockPushNotifications::FcmSendNotification.new(account_emails: accounts_email, name: hidden_place.place_name, type: type, title: title).call if accounts_email.present?
			image = hidden_place.images&.first&.service_url rescue nil
			accounts.each do |account_object|
        BxBlockPushNotifications::PushNotification.create(
          push_notificable: account_object,
          remarks: "New hidden place added",
					content: "New hidden place: #{hidden_place.place_name} created around you.",
					image: image,
					notify_type: 'hidden_place'
        )
      end
		end

		def events_around_the_place
			if params[:hidden_place_id].present?
				hidden_place = BxBlockHiddenPlaces::HiddenPlace.find_by(id: params[:hidden_place_id])
				return render json: {status: 404, error: 'No place found'}, status: 404 if hidden_place.blank?
				coordinates = hidden_place.to_coordinates.compact

				if coordinates.present? && coordinates.length == 2
					@events = BxBlockClubEvents::ClubEvent.where('DATE(start_date_and_time) >= ?', Date.today)
					@events = @events.near(coordinates, 100, units: :km)
					@events = @events.page(@page).per(@per_page)

					render json: {data: BxBlockSocialClubs::AroundPlaceEventsSerializer.new(@events).serializable_hash }, status: 200
				else
					render json: {status: 404, error: 'Location coordinates not found this place'}, status: 404	
				end
			else
				render json: {status: 404, error: 'Hidden place id is missing'}, status: 404
			end
		end

		private

		def load_hidden_place
			@hidden_place = BxBlockHiddenPlaces::HiddenPlace.find_by(account_id: @current_user.id, id: params[:id])
			return render json: {status: 422, message: 'Invalid id'}, status: 422 if @hidden_place.blank?
		end

		def load_place
			@hidden_place = BxBlockHiddenPlaces::HiddenPlace.find_by(id: params[:id])
			return render json: {status: 422, message: 'Invalid id'}, status: 422 if @hidden_place.blank?
		end

		# def current_user
  #     begin
  #       @current_user = AccountBlock::Account.find(@token.id)
  #     rescue ActiveRecord::RecordNotFound => e
  #       return render json: {errors: [
  #           {message: 'Please login again.'},
  #       ]}, status: :unprocessable_entity
  #     end
  #   end

		def create_params
			params.require(:data).permit(:place_name, :google_map_link, :description, :latitude, :longitude, :activity_ids, :travel_item_ids, :weather_ids, images: [])
		end

		def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << { attribute => error }
      end
      result
    end

		def resize_image
			create_params[:images].each do |img|
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
end
