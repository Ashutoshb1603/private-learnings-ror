module AccountBlock
    class Story < ApplicationRecord
        self.table_name = :stories
        belongs_to :objectable, polymorphic: true

        enum target: {'all_users': 1, 'elite': 2, 'glow_getter': 3, 'free': 4}
        has_one_attached :video

        has_many :story_views, class_name: 'AccountBlock::StoryView', dependent: :destroy
        
    end
end
