module BxBlockCatalogue
    class HeroProduct < ApplicationRecord
        self.table_name = :hero_products

        enum tags_type: {'default': 1, 'customized': 2}

        before_save :clear

        def clear
            if self.tags_type == "default"
                self.tags = ""
            end
        end
    end
end
