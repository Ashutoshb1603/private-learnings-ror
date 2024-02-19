module AccountBlock
    class DynamicImage < ApplicationRecord
        self.table_name = :dynamic_images
        enum image_type: {'profile_pic': 1, 'admin': 2, 'brand_image': 3, 'skin_hub': 4, 'email_logo': 5,
                            'email_cover': 6, 'visit_button': 7, 'email_tnc_icon': 8, 'policy_icon': 9, 'email_profile_icon': 10}

        validates_uniqueness_of :image_type
        has_one_attached :image
        has_one_attached :glow_getter_image
    end
end
