module BxBlockReviewAndApproval
  class ReviewAndApproval < ApplicationRecord
    enum approval_status: {"pending" => 0, "approved" => 1, "rejected" => 2}
    belongs_to :account, class_name: "AccountBlock::Account"
    belongs_to :reviewable, polymorphic: true, optional: true

    ROLE_ADMIN = "admin"
    ROLE_BASIC = "basic"
  end
end
