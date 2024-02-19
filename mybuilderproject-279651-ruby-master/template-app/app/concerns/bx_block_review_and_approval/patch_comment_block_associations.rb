module BxBlockReviewAndApproval
  module PatchCommentBlockAssociations
    extend ActiveSupport::Concern

    included do
      has_many :review_and_approval, as: :reviewable, class_name: "BxBlockReviewAndApproval::ReviewAndApproval"
    end
  end
end
