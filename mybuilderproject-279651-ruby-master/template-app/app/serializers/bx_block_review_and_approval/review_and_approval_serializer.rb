module BxBlockReviewAndApproval
  class ReviewAndApprovalSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes(:id, :account_id, :reviewable_id, :reviewable_type, :created_at, :updated_at, :approval_status, :reviewable, :account)
  end
end
