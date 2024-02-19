module BxBlockReviewAndApproval
  class ReviewAndApprovalsController < ApplicationController
    before_action :current_user, :check_account_role
    before_action :check_is_admin, only: [:update, :destroy]
    before_action :load_review_and_approval, only: [:show, :update, :destroy]

    def index
      review_and_approvals = ReviewAndApproval.all
      if review_and_approvals.present?
        render json: ReviewAndApprovalSerializer.new(review_and_approvals).serializable_hash, status: :ok
      else
        render json: {error: [message: "review_and_approval data is not present"]},
          status: 422
      end
    end

    def create
      if review_and_approval_params["reviewable_id"].nil? || review_and_approval_params["reviewable_id"] <= 0
        render json: {error: [message: "reviewable_id invalid"]},
          status: 400
      elsif review_and_approval_params["reviewable_type"] == "BxBlockPosts::Post"
        post = BxBlockPosts::Post.where(id: review_and_approval_params["reviewable_id"])
        if post.present?
          review_approval = ReviewAndApproval.find_by(reviewable_id: review_and_approval_params["reviewable_id"])
          if review_approval.nil?
            review_and_approval = current_user.review_and_approval.new(review_and_approval_params)
            if review_and_approval.save
              render json: ReviewAndApprovalSerializer.new(
                review_and_approval,
                meta: {
                  message: "review created."
                }
              ).serializable_hash, status: :created
            else
              render json: {errors: review_and_approval.errors},
                status: :unprocessable_entity
            end
          else
            render json: {message: "reviewable_id already exist"},
              status: :not_found
          end
        else
          render json: {message: "reviewable_id does not exist"},
            status: :not_found
        end
      else
        render json: {error: [message: "Only BxBlockPosts::Post can be used for reviewable type"]},
          status: 400
      end
    end

    def show
      render json: ReviewAndApprovalSerializer.new(@review_and_approval).serializable_hash, status: :ok
    end

    def update
      if valid_status?(review_and_approval_params["approval_status"])
        if @review_and_approval.update(review_and_approval_params)
          message = @review_and_approval.approved? ? "Status approved succesfully" : "Status rejected succesfully."
          render json: ReviewAndApprovalSerializer.new(
            @review_and_approval,
            meta: {message: message}
          ).serializable_hash, status: :ok
        else
          render json: {errors: format_activerecord_errors(@review_and_approval.errors)},
            status: :unprocessable_entity
        end
      else
        render json: {message: "Pass valid approval_status"},
          status: :unprocessable_entity
      end
    end

    def destroy
      if @review_and_approval.destroy
        render json: {message: "Review and Approval deleted succesfully!"}, status: :ok
      else
        render json: ReviewAndApprovalSerializer.new(@review_and_approval).serializable_hash,
          status: :unprocessable_entity
      end
    end

    private

    def check_is_admin
      unless current_user.is_review_and_approval_admin?
        render json: {
          errors: [{message: "Only admin account has permission for this"}]
        }, status: :unprocessable_entity
      end
    end

    def check_is_basic
      unless current_user.is_review_and_approval_basic?
        render json: {
          errors: [{message: "Only basic account has permission for this"}]
        }, status: :unprocessable_entity
      end
    end

    def check_account_role
      unless current_user.role.present? &&
          [ReviewAndApproval::ROLE_ADMIN, ReviewAndApproval::ROLE_BASIC].include?(current_user.role.name)
        render json: {
          errors: [{message: "Account does not have a proper role"}]
        }, status: :unprocessable_entity
      end
    end

    def review_and_approval_params
      params.require(:review_and_approval).permit(:reviewable_id, :reviewable_type, :approval_status)
    end

    def load_review_and_approval
      @review_and_approval = BxBlockReviewAndApproval::ReviewAndApproval.find_by(id: params[:id])
      if @review_and_approval.nil?
        render json: {message: "Does not exist"},
          status: :not_found
      end
    end

    def valid_status?(status)
      BxBlockReviewAndApproval::ReviewAndApproval.approval_statuses.keys.include?(status)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        result << {attribute => error}
      end
      result
    end
  end
end
