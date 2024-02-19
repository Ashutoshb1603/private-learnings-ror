module BxBlockCustomisableusersubscriptions
    class MembershipPlan < ApplicationRecord
        self.table_name = :membership_plans
        belongs_to :account, class_name: 'AccountBlock::Account'

        enum plan_type: {'glow_getter': 1, 'elite': 2}
    end
end
