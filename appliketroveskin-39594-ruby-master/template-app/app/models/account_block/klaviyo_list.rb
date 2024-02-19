module AccountBlock
    class KlaviyoList < ApplicationRecord
        self.table_name = 'klaviyo_lists'
        belongs_to :account, class_name: 'AccountBlock::Account'

        enum membership_list: {
            "unsubscribed": 1,
            'free' => 2,
            'glow_getter' => 3,
            'elite' => 4
        }

        enum non_subscribed_members_list: {
            "not_added": 1,
            'free_members_with_non_subscribed' => 2,
            'glow_getter_members_with_non_subscribed' => 3,
            'elite_members_with_non_subscribed' => 4
        }

        enum not_active_since_6_months: {
            'false' => 1,
            'free_list' => 2,
            'glow_getter_list' => 3,
            'elite_list' => 4
        }
    end
end
