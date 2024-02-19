module BxBlockReviewAndApproval
  module PatchAccountBlockAssociations
    extend ActiveSupport::Concern

    included do
      has_many :review_and_approval, class_name: "BxBlockReviewAndApproval::ReviewAndApproval", dependent: :destroy

      belongs_to :role, class_name: "BxBlockRolesPermissions::Role", required: false

      def is_review_and_approval_admin?
        role.present? && role.name == BxBlockReviewAndApproval::ReviewAndApproval::ROLE_ADMIN
      end

      def is_review_and_approval_basic?
        role.present? && role.name == BxBlockReviewAndApproval::ReviewAndApproval::ROLE_BASIC
      end
    end
  end
end
