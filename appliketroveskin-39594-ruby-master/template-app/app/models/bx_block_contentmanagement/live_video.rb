module BxBlockContentmanagement
    class LiveVideo < ApplicationRecord
        self.table_name = :live_videos

        has_many_attached :videos
        has_one_attached :image
        has_many :video_views, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubView', dependent: :destroy
        has_many :video_likes, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubLike', dependent: :destroy
        belongs_to :group, class_name: 'BxBlockCommunityforum::Group', optional: true
        enum status: {active: 1, inactive: 2, processing: 3}

        before_update :send_notification

        def send_notification
            if self.status_changed? and self.status == 'active'
                BxBlockNotifications::LiveVideoWorker.perform_async(self.id)
            end
        end
    end
end
