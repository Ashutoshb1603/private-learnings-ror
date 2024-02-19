module GenerateCoordinate
	extend ActiveSupport::Concern

	included do
		LATITUDE = /\@(-?[\d\.]*)/
    LONGITUDE = /\@[-?\d\.]*\,([-?\d\.]*)/

    LATITUDE1 = /ll=(-?[\d\.]*)/
    LONGITUDE1 = /ll=[-?\d\.]*\,([-?\d\.]*)/

		def generate_coordinates(url)
      begin
        response = Net::HTTP.get_response(URI(url))
        locations = response['location'].present? ? response['location'] : url
        self.latitude = (LATITUDE.match(locations)[1] || LATITUDE1.match(locations)[1]) rescue nil
        self.longitude = (LONGITUDE.match(locations)[1] || LONGITUDE1.match(locations)[1]) rescue nil
        
        if self.latitude.present? && self.longitude.present?
          results = Geocoder.search([self.latitude, self.longitude])
          self.city = (results.first.data['address']['city'] || results.first.data['address']['state']) rescue nil
        end
      rescue Exception => e
        error = e.message
      end
      self
    end

	end
end