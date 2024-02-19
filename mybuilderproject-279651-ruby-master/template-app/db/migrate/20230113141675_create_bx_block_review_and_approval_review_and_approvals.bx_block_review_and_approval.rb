# This migration comes from bx_block_review_and_approval (originally 20220321074654)
class CreateBxBlockReviewAndApprovalReviewAndApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_review_and_approval_review_and_approvals do |t|
      t.bigint :reviewable_id
      t.string :reviewable_type
      t.integer :account_id
      t.integer :approval_status, default: 0, null: false

      t.timestamps
    end
  end
end
