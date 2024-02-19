module BxBlockAdmin
    class EliteEligibility < ApplicationRecord
        self.table_name = :elite_eligibilities

        enum interval: {'lifetime': 1, 'year': 2, 'month': 3, 'week': 4, 'day': 5}
        enum eligibility_on: {'product_bought': 1, 'money_spent': 2}
        
    end
end
