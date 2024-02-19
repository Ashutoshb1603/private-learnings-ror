module AccountBlock
    class StoryView < ApplicationRecord
        self.table_name = :story_views

        belongs_to :story, class_name: 'AccountBlock::Story'
        belongs_to :accountable, polymorphic: true
        
    end
end
