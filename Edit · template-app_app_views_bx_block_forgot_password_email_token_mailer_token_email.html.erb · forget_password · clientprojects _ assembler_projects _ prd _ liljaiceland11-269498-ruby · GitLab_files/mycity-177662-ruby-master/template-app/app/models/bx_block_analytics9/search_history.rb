module BxBlockAnalytics9
	class SearchHistory < ApplicationRecord
		self.table_name = :search_histories

		enum history_type: {'home' => 'home', 'city' => 'city'}
	
	end
end
