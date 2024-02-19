module BxBlockPosts
  class HomeController < ApplicationController
    before_action :check_account_activated
    before_action :create_search_history, only: [:search]
    before_action :page_from_params, only: [:search, :search_by_location]

    def search
      if params[:search].present?
        lists = PgSearch.multisearch(params[:search])
      else
        lists = BxBlockAnalytics9::SearchDocument.order(created_at: :desc)
      end

      if params[:type].present?
        type = type_name(params[:type])
        if type.present?
          lists = lists.where(searchable_type: type)
          if type == 'BxBlockSocialClubs::SocialClub' && @current_user.present?
            lists = lists.where(language: @current_user.language)
          end
        end
      end

      lists = lists.where(status: "approved").order(created_at: :desc).page(@page).per(@per_page)
      data = BxBlockPosts::HomeSerializer.new(lists, serialization_options).serializable_hash
      render json: {status: 200, data: data}, status: 200
    end

    def get_search_histories
      if params[:type].present?
        histories = BxBlockAnalytics9::SearchHistory.where(account_id: @current_user.id, history_type: params[:type]).order(created_at: :desc).limit(10)
        render json: {data: histories.as_json(only: [:content]), status: 200}, status: 200
      else
        render json: {error: 'Type param is missing', status: 422}, status: 422
      end
    end

    def auto_suggestion_list
       matches = BxBlockAnalytics9::SearchDocument.search_by_name(params[:search]).order(created_at: :desc).limit(5)
       render json: {status: 200, data: matches.as_json(only: [:name, :searchable_type, :searchable_id])}, status: 200
    end

    def search_by_location
      lists = BxBlockAnalytics9::SearchDocument.where(status: "approved")
      if params[:type].present?
        type = type_name(params[:type])
        lists = lists.where(searchable_type: type) if type.present?

        if type == 'BxBlockSocialClubs::SocialClub'
          lists = search_clubs_by_interest(lists)
        end

        if params[:club_type].present?
          lists = lists.where(club_type: params[:club_type])
        end
      end

      if params[:search].present?
        lists = lists.search_by_words(params[:search])
      end

      if params[:city].present?
        create_location_search_history
        coordinates = Geocoder.search(params[:city]).first.coordinates
        create_google_place
        lists = lists.near(coordinates, 50, units: :km)

      elsif params[:latitude].present? && params[:longitude].present?
        create_google_place
        lists = lists.near([params[:latitude], params[:longitude]], 50, units: :km)
      end

      lists = lists.page(@page).per(@per_page)
      data = BxBlockPosts::HomeSerializer.new(lists, serialization_options).serializable_hash
      render json: {status: 200, data: data}, status: 200
    end

    def clear_history
      if params[:type].present?
        histories = BxBlockAnalytics9::SearchHistory.where(account_id: @current_user.id, history_type: params[:type])
        histories.destroy_all

        render json: {status: 200, message: 'Cleared your history'}, status: 200
      else
        render json: {status: 422, message: 'History type is missing'}, status: 422
      end
    end

    private

    def create_search_history
      BxBlockAnalytics9::SearchHistory.find_or_create_by(content: params[:search], account_id: @current_user.id, history_type: 'home') if params[:search].present? && @current_user.present?
    end

    def create_location_search_history
      BxBlockAnalytics9::SearchHistory.find_or_create_by(content: params[:city], account_id: @current_user.id, history_type: 'city') if params[:city].present? && @current_user.present?
    end

    def type_name(type)
      case type.downcase
      when 'places'
        ["BxBlockHiddenPlaces::HiddenPlace", "Google Place"]
      when 'clubs'
        'BxBlockSocialClubs::SocialClub'
      when 'events'
        'BxBlockClubEvents::ClubEvent'
      else
        ''
      end
    end

    def search_clubs_by_interest(lists)
      if @current_user.present?
        lists = lists.where(language: @current_user.preferred_language)
        interests = @current_user.interests.pluck(:name)
      else
        lists = lists.where(language: params[:language]) if params[:language].present?
        interests = params[:interests] || []
      end

      query = ""
      if interests.present?
        interests.each_with_index do |interest, index|
          query += ' OR ' if index > 0
          query += "content ILIKE '%#{interest.downcase}%'"
        end
      end

      lists = lists.where(query) if query.present?
      lists
    end

    def serialization_options
      options = {}
      options[:params] = { current_user: @current_user }
      options
    end

    def create_google_place
      attr = {}
      if params[:city].present?
        results = Geocoder.search(params[:city])
        coordinates = results.first.coordinates rescue []
        latitude = coordinates[0]
        longitude = coordinates[1]
        if latitude && longitude
          attr = {city: params[:city], latitude: latitude, longitude: longitude}
        end

      elsif params[:latitude].present? && params[:longitude].present?
        results = Geocoder.search([params[:latitude], params[:longitude]])
        city = results.first.data['address']['city'] rescue nil
        if city.present?
          attr = {city: city, latitude: params[:latitude], longitude: params[:longitude]}
        end
      end

      GooglePlaceWorker.perform_async(attr) if attr.present?
    end
  end
end
