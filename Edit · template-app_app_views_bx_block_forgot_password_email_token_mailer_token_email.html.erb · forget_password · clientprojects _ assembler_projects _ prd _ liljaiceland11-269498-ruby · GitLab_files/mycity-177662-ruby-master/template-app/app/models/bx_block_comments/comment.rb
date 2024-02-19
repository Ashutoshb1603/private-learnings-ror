module BxBlockComments
  class Comment < BxBlockComments::ApplicationRecord
    self.table_name = :comments

    validates :comment, presence: true

    belongs_to :account,
               class_name: 'AccountBlock::Account'

    belongs_to :commentable, polymorphic: true

    has_many :likes,
              as: :likeable, class_name: 'BxBlockLike::Like', dependent: :destroy

    def self.policy_class
      ::BxBlockComments::CommentPolicy
    end
  end
end
