module BxBlockContentmanagement
    class Tutorial < ApplicationRecord
        self.table_name = :tutorials

        has_many :tutorial_views, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubView', dependent: :destroy
        has_many :tutorial_likes, as: :objectable, class_name: 'BxBlockContentmanagement::SkinHubLike', dependent: :destroy
        belongs_to :group, class_name: 'BxBlockCommunityforum::Group'
        validates :url, format: {with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix, message: 'Please enter valid url'}

        def next
          Tutorial.select(:id, :title, :description).where("id > ?", self.id).first
        end

        def self.search(value)
          if value.present?
            results = self.joins(:group).
                      where("groups.title ilike '%#{value}%' 
                            or tutorials.title ilike '%#{value}%' 
                            or tutorials.description ilike '%#{value}%'").distinct
          end
          results
        end
    end
end
