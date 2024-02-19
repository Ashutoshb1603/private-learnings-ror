module BxBlockCommunityforum
    class Group < ApplicationRecord
        self.table_name = :groups
        enum status: {'active': 1, 'draft': 2}

        has_many :question_tags, class_name: 'BxBlockCommunityforum::QuestionTag', dependent: :destroy
        has_many :questions, through: :question_tags, class_name: 'BxBlockCommunityforum::Question'
    end
end