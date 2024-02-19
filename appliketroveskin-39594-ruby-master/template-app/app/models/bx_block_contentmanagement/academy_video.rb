module BxBlockContentmanagement
    class AcademyVideo < ApplicationRecord
        self.table_name = :academy_videos

        belongs_to :academy, class_name: 'BxBlockContentmanagement::Academy'
        
        validates :url, format: {with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'Please enter valid url'}

    end
end
