module BxBlockCommunityforum
    class QuestionTag < ApplicationRecord
        self.table_name = :question_tags

        belongs_to :group, class_name: 'BxBlockCommunityforum::Group'
        belongs_to :question, class_name: 'BxBlockCommunityforum::Question'
    end
end
