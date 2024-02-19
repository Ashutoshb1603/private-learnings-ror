module DocumentSearch
	extend ActiveSupport::Concern

	included do
		include PgSearch::Model
		has_one :search_document, class_name: 'BxBlockAnalytics9::SearchDocument'

		geocoded_by :address
		
		def address 
      [latitude, longitude].compact.join(", ") 
    end

    after_save :update_search_document
    after_destroy :delete_search_document
    
	end
end