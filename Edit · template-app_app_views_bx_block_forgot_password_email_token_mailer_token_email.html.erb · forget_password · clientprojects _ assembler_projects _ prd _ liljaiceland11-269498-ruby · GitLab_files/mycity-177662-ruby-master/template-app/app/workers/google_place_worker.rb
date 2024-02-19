class GooglePlaceWorker
	include Sidekiq::Worker
  sidekiq_options retry: true
  sidekiq_options :queue => 'default'

  def perform(attr)
    attr = attr.with_indifferent_access rescue {}
  	return if attr[:city].blank?
  	
  	integration = BxBlockHiddenPlaces::GooglePlaceIntegration.find_by(city: attr[:city])
    if integration.blank?
      integration = BxBlockHiddenPlaces::GooglePlaceIntegration.create(attr)
    end
  end
end