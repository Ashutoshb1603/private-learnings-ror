module BxBlockAnalytics9
	class SearchDocument < ApplicationRecord
		self.table_name = :pg_search_documents

		include PgSearch::Model
		geocoded_by :address

		def address 
      [latitude, longitude].compact.join(", ") 
    end

		belongs_to :searchable, :polymorphic => true, optional: true

		scope :search_by_type, -> (type){where(searchable_type: type)}

  	pg_search_scope :search_by_name, against: :name, using: {
                    	tsearch: { prefix: true }
                  	}

    pg_search_scope :search_by_words, against: [:content], 
                    using: {
                      tsearch: { prefix: true }
                    }

	
	end
end
