require "open-uri"
module BxBlockHiddenPlaces
  class GooglePlaceIntegration < ApplicationRecord
    self.table_name = :google_place_integrations
    
    PLACE_API_URL='https://maps.googleapis.com/maps/api/place/textsearch/json'
    IMAGE_URL='https://maps.googleapis.com/maps/api/place/photo'

    after_create :process_api

    def process_api
      1.upto(25).each do |request_count|
        next if request_count > 1 && page_token.blank?
        fetch_places
      end
    end

    def fetch_places
      url = PLACE_API_URL
      if page_token.present?
        url += "?pagetoken=#{page_token}"
      else
        url += "?location=#{latitude},#{longitude}"
      end
      url += "&radius=50000&type=point_of_interest&key=#{ENV['PLACE_API_KEY']}"

      response = URI.parse(url).read
      parse_response(response)
    end

    def parse_response(response)
      body = JSON.parse(response)
      page_token = body['next_page_token']
      
      results = []
      body['results'].each do |result|
        locations = result['geometry']['location'] || {}
        photo_reference = result['photos'].last.dig('photo_reference') rescue ''

        attr = {
          latitude: locations['lat'],
          longitude: locations['lng'],
          location: result['formatted_address'],
          content: result['name'],
          name: result['name'],
          searchable_type: 'Google Place',
          status: 'approved'
        }
        if photo_reference.present?
          attr[:google_place_url] = IMAGE_URL + "?maxwidth=400&photo_reference=#{photo_reference}&key=#{ENV['PLACE_API_KEY']}"
        end
        results << attr
      end
      upload_places(results)
      update_columns(page_token: page_token)
    end

    def upload_places(results)
      results.each do |result|
        document = BxBlockAnalytics9::SearchDocument.find_or_initialize_by(latitude: result[:latitude], longitude: result[:longitude], name: result[:name])
        document.assign_attributes(result)
        document.save
      end
    end

  end
end
